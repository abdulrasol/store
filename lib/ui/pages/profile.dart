import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:store/database/services/controller.dart';
import 'package:store/ui/widgets/decoration.dart';
import 'package:store/ui/widgets/generic_app_bar.dart';

import '../widgets/login.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final controller = Get.put(Controller());

  final btnController = RoundedLoadingButtonController();

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
                          const CircleAvatar(
                            radius: 75, // Adjust the radius as needed
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
                                onPressed: () {
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
                        Text(controller.user.value!.displayName ??
                            'edit your name!'),
                        const Expanded(child: sizedBox),
                        IconButton(
                            onPressed: () async {
                              void updateState() {
                                setState(() {});
                              }

                              await changeUserInfo(context,
                                  upadedState: updateState);
                            },
                            icon: const Icon(Icons.edit)),
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
                            onPressed: () {
                              FirebaseAuth.instance.sendPasswordResetEmail(
                                  email: controller.user.value!.email ??
                                      'edit your email!');
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
