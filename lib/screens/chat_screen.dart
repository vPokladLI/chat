import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfire_ui/firestore.dart';
import '../services/firebase_service.dart';

import '../widgets/chat/new_message.dart';
import '../widgets/chat/messageBubble.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final db = DataBase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: FirestoreListView(
                reverse: true,
                query: db.messages,
                itemBuilder: (context, doc) => MessageBubble(doc['text']),
              ),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
