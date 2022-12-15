import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../helpers/http_exception.dart';

class Auth {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> registerWithEmailPassword(
      String email, String password, String name) async {
    try {
      final authResponse = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (authResponse.user != null) {
        await authResponse.user?.sendEmailVerification();
        await authResponse.user?.updateDisplayName(name);
        await authResponse.user?.updatePhotoURL(
            'https://firebasestorage.googleapis.com/v0/b/chat-715d6.appspot.com/o/user_img%2Favatar_placeholder.jpg?alt=media&token=824e372b-b52e-4522-9fdb-5e3127141fba');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw HttpException('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw HttpException('The account already exists for that email.');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> loginWithEmailPassword(
      String emailAddress, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw HttpException('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw HttpException('Wrong password or email provided for that user.');
      }
    }
  }

  Stream<User?> get userChanges {
    return _auth.authStateChanges();
  }

  User? get user {
    return _auth.currentUser;
  }

  Future<void>? updateName(String name) {
    return user?.updateDisplayName(name);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
