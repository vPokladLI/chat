import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class ProfileScreenFlutter extends StatelessWidget {
  const ProfileScreenFlutter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfileScreen(
        providerConfigs: [
          EmailProviderConfiguration(),
        ],
        avatarSize: 36,
      ),
    );
  }
}
