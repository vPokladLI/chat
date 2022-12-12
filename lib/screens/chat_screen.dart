import 'package:flutter/material.dart';
import '../widgets/chat/message_bubble.dart';

import 'package:flutterfire_ui/firestore.dart';
import '../services/firebase_service.dart';
import '../services/auth_service.dart';

import '../widgets/chat/new_message.dart';

import '../widgets/app_drawer.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final db = DataBase();
  final auth = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat room'),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: FirestoreListView(
                reverse: true,
                query: db.messages,
                itemBuilder: (context, doc) => messageBubble(
                    context, auth.user?.uid == doc['userId'], doc['text']),
                // itemBuilder: (context, doc) => BubbleSpecialThree(
                //   text: doc['text'],
                //   isSender: auth.user?.uid == doc['userId'],
                //   color: auth.user?.uid == doc['userId']
                //       ? Color(0xFF1B97F3)
                //       : Color(0xFFE8E8EE),
                //   tail: true,
                //   textStyle: TextStyle(
                //       color: auth.user?.uid == doc['userId']
                //           ? Colors.white
                //           : Colors.black,
                //       fontSize: 16),
                // ),
              ),
            ),
            const NewMessage(),
          ],
        ),
      ),
    );
  }
}
