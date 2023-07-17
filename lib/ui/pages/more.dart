import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'orders.dart';

class More extends StatelessWidget {
  const More({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.black87),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.login),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
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
              Get.to(const Orders());
            },
            leading: const Icon(
              Icons.shopping_bag,
            ),
            title: const Text('My Orders'),
          ),
          const SizedBox(height: 20),
          ListTile(
            onTap: () {},
            leading: const Icon(
              CupertinoIcons.profile_circled,
            ),
            title: const Text('My profile'),
          ),
          const SizedBox(height: 20),
          ListTile(
            onTap: () {},
            leading: const Icon(
              CupertinoIcons.settings,
            ),
            title: const Text('Settings'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
