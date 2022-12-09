import 'package:cloud_firestore/cloud_firestore.dart';

class DataBase {
  final _db = FirebaseFirestore.instance;

  addMessage(String message) {
    _db
        .collection('/chats/npZCdKKwmsSgKQXPYlYp/messages')
        .add({"text": message, "createdAt": Timestamp.now()});
  }

  get messages {
    return _db
        .collection('/chats/npZCdKKwmsSgKQXPYlYp/messages')
        .orderBy('createdAt', descending: true);
  }
}
