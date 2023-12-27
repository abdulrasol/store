import 'dart:convert';

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

import 'user_adress_list.dart';
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
              _buildProfileImage(),
              const SizedBox(height: 50),
              _buildSectionTitle('Shopping'),
              const Divider(),
              _buildOrdersSection(),
              const SizedBox(height: 50),
              _buildSectionTitle('Account Settings'),
              const Divider(),
              _buildProfileSection(),
              _buildShippingAddressesSection(),
              const SizedBox(height: 35),
              _buildSectionTitle('Application'),
              const Divider(),
              _buildAppOptionsSection(),
              _buildAboutSection(),
              const SizedBox(height: 35),
              _buildSignOutButton(),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build the user's profile image
  Widget _buildProfileImage() {
    return SizedBox(
      width: double.infinity,
      height: 175,
      child: Obx(
        () => CircleAvatar(
          radius: 75,
          backgroundColor: Colors.grey,
          backgroundImage: controller.userData.value.profileImage != ''
              ? MemoryImage(
                  base64Decode(
                    controller.userData.value.profileImage,
                  ),
                )
              : null,
          child: controller.user.value == null
              ? const Icon(
                  CupertinoIcons.person_alt_circle_fill,
                  size: 175,
                  color: Colors.black54,
                )
              : null,
        ),
      ),
    );
  }

  // Helper method to build section titles
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 17),
      child: Text(
        title,
        style: const TextStyle(color: Colors.black54, fontSize: 16),
      ),
    );
  }

  // Helper method to build the Orders section
  Widget _buildOrdersSection() {
    return SettingsSectionWidgetCard(
      controller: controller,
      icon: Icons.shop_2_sharp,
      title: 'Orders',
      newPage: const Orders(),
      buttonBorder: 0,
      loginRequired: true,
    );
  }

  // Helper method to build the Profile section
  Widget _buildProfileSection() {
    return SettingsSectionWidgetCard(
      controller: controller,
      icon: CupertinoIcons.profile_circled,
      title: 'Profile',
      newPage: const Profile(),
      buttonBorder: 0,
      loginRequired: true,
    );
  }

  // Helper method to build the Shipping Addresses section
  Widget _buildShippingAddressesSection() {
    return SettingsSectionWidgetCard(
      controller: controller,
      icon: CupertinoIcons.location_solid,
      title: 'Shipping Addresses',
      newPage: const UserAddressList(),
      buttonBorder: 2,
      loginRequired: true,
    );
  }

  // Helper method to build the Application Options section
  Widget _buildAppOptionsSection() {
    return SettingsSectionWidgetCard(
      controller: controller,
      icon: CupertinoIcons.gear_alt_fill,
      title: 'Options',
      newPage: const AppOptions(),
      buttonBorder: 0,
      loginRequired: false,
    );
  }

  // Helper method to build the About section
  Widget _buildAboutSection() {
    return SettingsSectionWidgetCard(
      controller: controller,
      icon: CupertinoIcons.info_circle_fill,
      title: 'About',
      newPage: const About(),
      buttonBorder: 2,
      loginRequired: false,
    );
  }

  // Helper method to build the sign-out or sign-in button based on user authentication
  Widget _buildSignOutButton() {
    return Obx(
      () => controller.user.value != null
          ? _buildLogoutButton()
          : _buildSignInButton(),
    );
  }

  // Helper method to build the Logout button
  Widget _buildLogoutButton() {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          backgroundColor: Colors.black87,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(10.0)), // Set the desired border radius here
          ),
          minimumSize: const Size(300, 50.0),
        ),
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
        },
        child: const Text('Log out'),
      ),
    );
  }

  // Helper method to build the Sign-In button
  Widget _buildSignInButton() {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          backgroundColor: Colors.black87,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(10.0)), // Set the desired border radius here
          ),
          minimumSize: const Size(300, 50.0),
        ),
        onPressed: () {
          Get.to(() => const AuthPage());
        },
        child: const Text('Sign in'),
      ),
    );
  }
}
