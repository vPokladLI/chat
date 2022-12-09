import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfire_ui/firestore.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FirestoreListView(
        query: db.collection('/chats/npZCdKKwmsSgKQXPYlYp/messages'),
        itemBuilder: (context, doc) => Text(doc['text']),
      ),
      // sbody: StreamBuilder(
      //     stream:
      //         db.collection('/chats/npZCdKKwmsSgKQXPYlYp/messages').snapshots(),
      //     builder: (context, streamSnapshot) {
      //       if (streamSnapshot.connectionState == ConnectionState.waiting) {
      //         return Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       }
      //       return ListView.builder(
      //           itemCount: streamSnapshot.data?.docs.length,
      //           itemBuilder: (context, index) => Container(
      //                 padding: EdgeInsets.all(10),
      //                 child: Text(streamSnapshot.data?.docs[index]['text']),
      //               ));
      //     }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          db
              .collection('/chats/npZCdKKwmsSgKQXPYlYp/messages')
              .add({'text': 'Dummy text'});
        },
        child: Icon(Icons.access_time_filled),
      ),
    );
  }
}
