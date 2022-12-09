import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import './chat_screen.dart';
import './profile_screen.dart';
import './auth_screen.dart';
import './chat_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const AuthScreen();
          }
          if (snapshot.data!.emailVerified != true) {
            return const ProfileScreenFlutter();
          }
          return ChatScreen();
        });
  }
}
