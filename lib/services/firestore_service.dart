import 'package:cloud_firestore/cloud_firestore.dart';

class DataBase {
  final _db = FirebaseFirestore.instance;

  addMessage(String message, String id) {
    _db
        .collection('/chats/npZCdKKwmsSgKQXPYlYp/messages')
        .add({"text": message, "createdAt": Timestamp.now(), "userId": id});
  }

  get messages {
    return _db
        .collection('/chats/npZCdKKwmsSgKQXPYlYp/messages')
        .orderBy('createdAt', descending: true);
  }

  Future findUserById(String id) {
    return _db.collection('users').doc(id).get();
  }

  Future<void> setUserData(
      {required String id,
      required String email,
      String name = 'User',
      String avatar =
          'https://firebasestorage.googleapis.com/v0/b/chat-715d6.appspot.com/o/user_img%2Favatar_placeholder.jpg?alt=media&token=824e372b-b52e-4522-9fdb-5e3127141fba'}) {
    return _db.collection('users').doc(id).set({
      "email": email,
      "name": name,
      "avatar": avatar,
    });
  }
}
