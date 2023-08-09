import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/database/services/controller.dart';
import 'package:store/ui/pages/auth_page.dart';
import 'package:store/ui/pages/profile.dart';
import 'package:store/ui/pages/settings.dart';

import 'orders.dart';

class More extends StatelessWidget {
  More({super.key});
  final controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'More',
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
          const SizedBox(height: 20),
          ListTile(
            onTap: () {
              Get.to(() => const Orders());
            },
            leading: const Icon(
              Icons.shopping_bag,
            ),
            title: const Text('My Orders'),
          ),
          const SizedBox(height: 20),
          ListTile(
            onTap: () {
              Get.to(() => const Prfile());
            },
            leading: const Icon(
              CupertinoIcons.profile_circled,
            ),
            title: const Text('My profile'),
          ),
          const SizedBox(height: 20),
          ListTile(
            onTap: () {
              Get.to(() => const Options());
            },
            leading: const Icon(
              CupertinoIcons.settings,
            ),
            title: const Text('Settings'),
          ),
          const SizedBox(height: 20),
          Obx(
            () => controller.user.value != null
                ? ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(2),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.black87),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Set the desired border radius here
                        ),
                      ),
                      minimumSize:
                          MaterialStateProperty.all(const Size(300, 50.0)),
                    ),
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                    },
                    child: const Text(
                      'Log out',
                    ),
                  )
                : ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(2),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.black87),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Set the desired border radius here
                        ),
                      ),
                      minimumSize:
                          MaterialStateProperty.all(const Size(300, 50.0)),
                    ),
                    onPressed: () {
                      Get.to(() => const AuthPage());
                    },
                    child: const Text('Sign in'),
                  ),
          )
        ],
      ),
    );
  }
}
