import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_4.dart';

import '../../services/auth_service.dart';
import '../../services/firestore_service.dart';

final auth = Auth();
final db = DataBase();
Widget messageBubble(
    {context, required String message, required String userId}) {
  if (auth.user?.uid == userId) {
    return ChatBubble(
      clipper: ChatBubbleClipper4(type: BubbleType.sendBubble),
      alignment: Alignment.topRight,
      margin: EdgeInsets.only(top: 20),
      backGroundColor: Colors.blue,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
  return FutureBuilder(
      future: db.findUserById(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CircleAvatar(
                  maxRadius: 25,
                  backgroundImage: NetworkImage(
                      'https://firebasestorage.googleapis.com/v0/b/chat-715d6.appspot.com/o/user_img%2Favatar_placeholder.jpg?alt=media&token=824e372b-b52e-4522-9fdb-5e3127141fba')),
              SizedBox(
                width: 5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                        minWidth: 50),
                    padding: const EdgeInsets.only(
                      left: 8,
                    ),
                    child: FittedBox(
                        child: Text(
                      snapshot.data['name'],
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Colors.black38),
                    )),
                  ),
                  ChatBubble(
                    clipper:
                        ChatBubbleClipper4(type: BubbleType.receiverBubble),
                    alignment: Alignment.topLeft,
                    // margin: EdgeInsets.only(top: 20),
                    backGroundColor: Color(0xffE7E7ED),
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                          minWidth: 50),
                      child: Text(
                        message,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      });
}
