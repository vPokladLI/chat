import 'firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './screens/chat_screen.dart';
import './screens/auth_gate.dart';
import './screens/profile_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
    androidProvider: AndroidProvider.debug,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 15, 26, 57),

        colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromARGB(255, 15, 26, 57),
            tertiary: Color.fromARGB(255, 237, 150, 20),
            onBackground: Colors.white),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
      ),
      home: AuthGate(),
      routes: {
        ChatScreen.routName: (context) => ChatScreen(),
        ProfileScreen.routName: (context) => ProfileScreen()
      },
    );
  }
}
