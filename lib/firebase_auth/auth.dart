import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';

class AuthService {
  var logger = Logger(
      printer: PrettyPrinter(
    lineLength: 200,
    printTime: false,
    printEmojis: true,
  ));
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      logger.i('user with uid: ${_firebaseAuth.currentUser!.uid} signed in.');
      await EasyLoading.showSuccess('successfully signed in');
    } on FirebaseException catch (e) {
      await EasyLoading.showError(e.message.toString());
      logger.e(e.message);
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      logger.i(_firebaseAuth.currentUser!.uid);
      await EasyLoading.showSuccess('successfully registered..');
    } on FirebaseException catch (e) {
      await EasyLoading.showError(e.message.toString());
      logger.e(e.message);
      return;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();

      if (_firebaseAuth.currentUser == null) {
        logger.d('user has signed out');
      }

      return;
    } on FirebaseException catch (e) {
      logger.e(e.message ?? 'something went wrong');
      await EasyLoading.showError(e.message ?? 'something went wrong');
    }
  }
}
