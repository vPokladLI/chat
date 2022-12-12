import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_4.dart';

Widget messageBubble(context, bool isMe, String message) {
  if (isMe) {
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
  return Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      CircleAvatar(
        maxRadius: 20,
        backgroundImage: NetworkImage('https://i.pravatar.cc/40'),
      ),
      SizedBox(
        width: 5,
      ),
      ChatBubble(
        clipper: ChatBubbleClipper4(type: BubbleType.receiverBubble),
        alignment: Alignment.topLeft,
        margin: EdgeInsets.only(top: 20),
        backGroundColor: Color(0xffE7E7ED),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            message,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    ],
  );
}
