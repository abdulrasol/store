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
import 'package:store/database/services/storage.dart';
import 'package:store/ui/widgets/decoration.dart';
import 'package:store/ui/widgets/generic_app_bar.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import '../widgets/login.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final controller = Get.put(Controller());
  final btnController = RoundedLoadingButtonController();

  // bool selectImage = false;
  Uint8List imageSelected = Uint8List(0);
  Future<Uint8List> selectImage() async {
    FilePickerResult? image = await FilePicker.platform.pickFiles(
      type: FileType.image,
      dialogTitle: 'Select profile Picture',
    );
    if (image != null) {
      imageSelected = await FlutterImageCompress.compressWithList(
        image.files[0].bytes!,
        quality: 50,
      );
      // final ref = userProfileRef.child(controller.user.value!.uid);
      // await ref.putData(imageSelected).then((p0) => p0.ref.storage);
      await Auth.updateUserData({
        'profileImage': imageSelected,
      });
      setState(() {});
      return image.files[0].bytes!;
    }

    return Uint8List(0);
  }

  Future<void> imagePicker() async {
    Uint8List? imageList;

    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      await Auth.updateUserData({
        'profileImage': base64Encode(
          imageList!.toList(),
        )
      });
      await controller.updateUserImagePrifle();
      setState(() {});
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
                            backgroundImage: MemoryImage(
                              controller.userData.value.imageData,
                            ),
                            // child: Image.memory(imageSelected),
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
                                onPressed: () async {
                                  await selectImage();
                                  // Handle edit profile picture action
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    sizedBox,
                    // name
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text('Full Name'),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const SizedBox(width: 15),
                        const Icon(CupertinoIcons.person),
                        const SizedBox(width: 15),
                        Text(FirebaseAuth.instance.currentUser?.displayName ??
                            'edit your name!'),
                        const Expanded(child: sizedBox),
                        IconButton(
                          onPressed: () async {
                            await Get.defaultDialog(
                              titlePadding: const EdgeInsets.only(top: 15),
                              title: 'update your full name',
                              content: const UpdateprofileInfo(
                                nameOrEmail: true,
                              ),
                            ).then((value) {
                              setState(() {});
                            });
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      ],
                    ),
                    const SizedBox(height: 35),
                    // email
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text('Email'),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const SizedBox(width: 15),
                        const Icon(CupertinoIcons.at),
                        const SizedBox(width: 15),
                        Text(
                            controller.user.value!.email ?? 'edit your email!'),
                        const Expanded(child: sizedBox),
                        IconButton(
                            onPressed: () async {
                              await Get.defaultDialog(
                                titlePadding: const EdgeInsets.only(top: 15),
                                title: 'update email',
                                content: const UpdateprofileInfo(
                                  nameOrEmail: false,
                                ),
                              ).then((value) {
                                setState(() {});
                              });
                            },
                            icon: const Icon(Icons.edit)),
                      ],
                    ),
                    const SizedBox(height: 35),
                    RoundedLoadingButton(
                      color: Colors.red,
                      controller: btnController,
                      onPressed: () {},
                      child: const Text('Reset Password'),
                    )
                    //
                  ],
                )
              : LoginWidget(),
        ),
      ),
    );
  }

  Future<void> changeUserInfo(
    BuildContext context, {
    String title = 'Change your Full Name',
    String buttonText = 'change your email',
    bool nameOrEmail = true,
    required Function upadedState,
  }) async {
    final GlobalKey<FormState> key = GlobalKey<FormState>();
    final btnController = RoundedLoadingButtonController();
    final textController = TextEditingController();

    showModalBottomSheet(
        context: context,
        builder: (context) => BottomSheet(onClosing: () {
              upadedState();
            }, builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: key,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      sizedBox,
                      Text(title),
                      sizedBox,
                      TextFormField(
                        decoration: inputDecoration.copyWith(
                          label: Text(nameOrEmail
                              ? 'Type  Full name'
                              : 'Type Your Email'),
                        ),
                        controller: textController,
                        validator: (value) {
                          if (nameOrEmail) {
                            if (value == null) {
                              return 'please write your name';
                            }
                            return null;
                          } else {
                            if (value == '') {
                              return 'please write your email';
                            }
                            if (!GetUtils.isEmail(value!)) {
                              return 'enter valide email';
                            } else {
                              return null;
                            }
                          }
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
                                  ?.updateEmail(textController.text)
                                  .then(
                                    (value) => Get.back(),
                                  );
                            }
                          } else {
                            btnController.reset();
                          }
                        },
                        child: Text(buttonText),
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}

class UpdateprofileInfo extends StatelessWidget {
  final bool nameOrEmail;

  const UpdateprofileInfo({super.key, required this.nameOrEmail});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> key = GlobalKey<FormState>();
    final btnController = RoundedLoadingButtonController();
    final textController = TextEditingController();
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
                  } else {
                    return null;
                  }
                } else if (!nameOrEmail) {
                  if (value == '') {
                    return 'please write your email';
                  }
                  if (!GetUtils.isEmail(value!)) {
                    return 'enter valide email';
                  } else {
                    return null;
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
