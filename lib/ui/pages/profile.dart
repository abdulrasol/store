import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:store/database/services/auth.dart';
import 'package:store/database/services/controller.dart';
import 'package:store/ui/widgets/decoration.dart';
import 'package:store/ui/widgets/generic_app_bar.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import '../widgets/login.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final controller = Get.put(Controller());
  final btnController = RoundedLoadingButtonController();

  Future<void> selectImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      dialogTitle: 'Select profile Picture',
    );

    if (result != null) {
      Uint8List imageBytes = result.files.single.bytes!;

      // Compress and resize the image if needed
      imageBytes = await FlutterImageCompress.compressWithList(
        imageBytes,
        quality: 50,
        minHeight: 200, // Set your preferred image height
        minWidth: 200, // Set your preferred image width
      );

      // Convert the image to a base64-encoded string
      String base64Image = base64Encode(imageBytes);

      // Update the user's data in Firebase
      await Auth.updateUserData({'profileImage': base64Image});

      // Update the UI to reflect the new image
      setState(() {
        controller.userData.value.profileImage = base64Image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: genericAppBar(
        title: 'Profile',
        withBackAction: true,
        centerTitle: true,
        showSearchIcon: false,
        context: context,
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => controller.user.value != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sizedBox,
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 75, // Adjust the radius as needed
                            backgroundImage:
                                controller.userData.value.profileImage != ''
                                    ? MemoryImage(
                                        base64Decode(
                                          controller
                                              .userData.value.profileImage,
                                        ),
                                      )
                                    : null,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: selectImage,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    sizedBox,
                    _buildProfileInfo(
                      label: 'Full Name',
                      icon: CupertinoIcons.person,
                      value: FirebaseAuth.instance.currentUser?.displayName ??
                          'edit your name!',
                      onPressed: () async {
                        await _showUpdateDialog(
                          title: 'Update your Full Name',
                          nameOrEmail: true,
                        );
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 35),
                    _buildProfileInfo(
                      label: 'Email',
                      icon: CupertinoIcons.at,
                      value: controller.user.value!.email ?? 'edit your email!',
                      onPressed: () async {
                        await _showUpdateDialog(
                          title: 'Update Email',
                          nameOrEmail: false,
                        );
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 35),
                    RoundedLoadingButton(
                      color: Colors.red,
                      controller: btnController,
                      onPressed: () {},
                      child: const Text('Reset Password'),
                    ),
                  ],
                )
              : LoginWidget(),
        ),
      ),
    );
  }

  Widget _buildProfileInfo({
    required String label,
    required IconData icon,
    required String value,
    required VoidCallback onPressed,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(label),
        ),
        const Divider(),
        Row(
          children: [
            const SizedBox(width: 15),
            Icon(icon),
            const SizedBox(width: 15),
            Text(value),
            const Expanded(child: sizedBox),
            IconButton(
              onPressed: onPressed,
              icon: const Icon(Icons.edit),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _showUpdateDialog({
    required String title,
    required bool nameOrEmail,
  }) async {
    final GlobalKey<FormState> key = GlobalKey<FormState>();
    final btnController = RoundedLoadingButtonController();
    final textController = TextEditingController();

    await Get.defaultDialog(
      titlePadding: const EdgeInsets.only(top: 15),
      title: title,
      content: _UpdateProfileInfo(
        nameOrEmail: nameOrEmail,
        key: key,
        textController: textController,
        btnController: btnController,
      ),
    );

    setState(() {});
  }
}

class _UpdateProfileInfo extends StatelessWidget {
  final bool nameOrEmail;
  @override
  // ignore: overridden_fields
  final GlobalKey<FormState> key;
  final TextEditingController textController;
  final RoundedLoadingButtonController btnController;

  const _UpdateProfileInfo({
    required this.nameOrEmail,
    required this.key,
    required this.textController,
    required this.btnController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: key,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: inputDecoration.copyWith(
                label: Text(
                  nameOrEmail ? 'your name' : 'your Email',
                  style: const TextStyle(color: Colors.black87),
                ),
              ),
              controller: textController,
              validator: (value) {
                if (nameOrEmail) {
                  if (value == '') {
                    return 'please write your name';
                  }
                } else {
                  if (value == '') {
                    return 'please write your email';
                  }
                  if (!GetUtils.isEmail(value!)) {
                    return 'enter a valid email';
                  }
                }
                return null;
              },
              onChanged: (value) {
                btnController.reset();
              },
            ),
            sizedBox,
            RoundedLoadingButton(
              borderRadius: 8,
              color: Colors.black87,
              successColor: Colors.black87,
              errorColor: Colors.red.shade300,
              controller: btnController,
              onPressed: () async {
                if (key.currentState!.validate()) {
                  if (nameOrEmail) {
                    await FirebaseAuth.instance.currentUser
                        ?.updateDisplayName(textController.text)
                        .then(
                          (value) => Get.back(),
                        );
                  } else {
                    await FirebaseAuth.instance.currentUser
                        ?.verifyBeforeUpdateEmail(textController.text)
                        .then(
                          (value) => Get.back(),
                        );
                  }
                } else {
                  btnController.reset();
                }
              },
              child: const Text('update'),
            )
          ],
        ),
      ),
    );
  }
}
