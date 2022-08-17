import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nuclear/screens/mobile/login.dart';
import 'package:nuclear/screens/shared/home.dart';
import 'package:provider/provider.dart';

class Authenticator extends StatelessWidget {
  const Authenticator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    return firebaseUser != null ? const Home() : const MobileLoginView();
  }
}
