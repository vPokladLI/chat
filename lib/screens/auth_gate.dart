import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import './chat_screen.dart';
import './profile_screen.dart';
import './auth_screen.dart';
import './chat_screen.dart';

class AuthGate extends StatelessWidget {
  AuthGate({super.key});
  final _auth = Auth();
  final _db = DataBase();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: _auth.userChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            if (user == null) {
              return const AuthScreen();
            }
            _db.setUserData(
                id: user.uid,
                email: user.email!,
                name: user.displayName!,
                avatar: user.photoURL!);

            return ChatScreen();
          } else {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          // if (!snapshot.hasData) {
          //   return SignInScreen(
          //     providerConfigs: [EmailProviderConfiguration()],
          //   );
          // }

          // if (snapshot.data!.emailVerified != true) {
          //   return const ProfileScreenFlutter();
          // }
        });
  }
}
