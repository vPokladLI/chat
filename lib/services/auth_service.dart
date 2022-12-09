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
      await _db
          .collection('users')
          .doc(authResponse.user?.uid)
          .set({"email": email, "name": name});
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

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Stream<User?> get currentUser {
    return _auth.authStateChanges();
  }
}
