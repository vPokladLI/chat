import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../helpers/custom_route.dart';

import '../services/auth_service.dart';

class AppDrawer extends StatelessWidget {
  final _auth = Auth();
  AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(
          automaticallyImplyLeading: false,
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.shop),
          title: const Text('Shop'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.payment),
          title: const Text('Orders'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.paste_sharp),
          title: const Text('User products'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.logout_outlined),
          title: const Text(' Logout'),
          onTap: () {
            _auth.signOut();
            Navigator.of(context).pushReplacementNamed('/');
          },
        ),
      ]),
    );
  }
}
