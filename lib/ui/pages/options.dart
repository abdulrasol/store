import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/database/services/controller.dart';
import 'package:store/ui/pages/about.dart';
import 'package:store/ui/pages/auth_page.dart';
import 'package:store/ui/pages/profile.dart';
import 'package:store/ui/pages/app_options.dart';
import 'package:store/ui/widgets/generic_app_bar.dart';
import 'package:store/ui/widgets/options_section_card.dart';

import 'orders.dart';

class Options extends StatelessWidget {
  Options({super.key});
  final controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: genericAppBar(
        title: 'Settings',
        withBackAction: false,
        centerTitle: true,
        showSearchIcon: false,
        context: context,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const SizedBox(
                width: double.infinity,
                height: 175,
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(
                    CupertinoIcons.person_alt_circle_fill,
                    size: 175,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              const Padding(
                padding: EdgeInsets.only(left: 17),
                child: Text(
                  'Shopping',
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
              ),
              const Divider(),
              SettingsSectionWidgetCard(
                controller: controller,
                icon: Icons.shop_2_sharp,
                title: 'Orders',
                newPage: const Orders(),
                buttonBorder: 0,
                loginRequired: true,
              ),
              const SizedBox(height: 50),
              const Padding(
                padding: EdgeInsets.only(left: 17),
                child: Text(
                  'Account Settings',
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
              ),
              const Divider(),
              SettingsSectionWidgetCard(
                controller: controller,
                icon: CupertinoIcons.profile_circled,
                title: 'Profile',
                newPage: const Profile(),
                buttonBorder: 0,
                loginRequired: true,
              ),
              SettingsSectionWidgetCard(
                controller: controller,
                icon: CupertinoIcons.location_solid,
                title: 'Shipping Adresses',
                newPage: const Profile(),
                buttonBorder: 2,
                loginRequired: true,
              ),
              const SizedBox(height: 35),
              const Padding(
                padding: EdgeInsets.only(left: 17),
                child: Text(
                  'Application',
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
              ),
              const Divider(),
              SettingsSectionWidgetCard(
                controller: controller,
                icon: CupertinoIcons.gear_alt_fill,
                title: 'Options',
                newPage: const AppOptions(),
                buttonBorder: 0,
                loginRequired: false,
              ),
              SettingsSectionWidgetCard(
                controller: controller,
                icon: CupertinoIcons.info_circle_fill,
                title: 'About',
                newPage: const About(),
                buttonBorder: 2,
                loginRequired: false,
              ),
              const SizedBox(height: 35),
              Obx(
                () => controller.user.value != null
                    ? Center(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(2),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black87),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Set the desired border radius here
                              ),
                            ),
                            minimumSize: MaterialStateProperty.all(
                                const Size(300, 50.0)),
                          ),
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                          },
                          child: const Text(
                            'Log out',
                          ),
                        ),
                      )
                    : Center(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(2),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black87),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Set the desired border radius here
                              ),
                            ),
                            minimumSize: MaterialStateProperty.all(
                                const Size(300, 50.0)),
                          ),
                          onPressed: () {
                            Get.to(() => const AuthPage());
                          },
                          child: const Text('Sign in'),
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
