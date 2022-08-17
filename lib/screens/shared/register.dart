import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nuclear/auth/auth.dart';
import 'package:nuclear/constants/strings.dart';
import 'package:provider/provider.dart';

import '../../constants/route_constants.dart';
import '../../widgets/custom/customButtons.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  String? errorMessage = '';
  final _formkey = GlobalKey<FormState>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  var logger = Logger(
      printer: PrettyPrinter(
          methodCount: 8,
          lineLength: 300,
          printTime: false,
          printEmojis: true,
          colors: true));
  final _emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  late bool isObscured = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    logger.d('initState: RegisterWidget');
  }

  String? _emailInputValidator(String? value) {
    if (value == null || value.isEmpty) {
      logger.d('email field empty');
      return 'Cannot be empty';
    }
    if (!_emailRegex.hasMatch(value)) {
      return 'Not a valid email try again';
    }
    return null;
  }

  String? _passwordInputValidator(String? value) {
    if (value == null || value.isEmpty) {
      logger.d('password field empty');
      return 'password field cannot be empty';
    }
    if (value.length <= 6) {
      return 'Password needs to be longer than 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthService>();
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(title: const Text(Strings.homeTitle)),
      body: Form(
        key: _formkey,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              children: [
                const SizedBox(
                    height: 200,
                    width: 150,
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Register',
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ))),
                const SizedBox(height: 10),
                TextFormField(
                  validator: _emailInputValidator,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextFormField(
                  validator: _passwordInputValidator,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: isObscured,
                  obscuringCharacter: '*',
                  controller: _passwordController,
                  decoration: InputDecoration(
                      labelText: 'password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() => isObscured = !isObscured);
                        },
                        icon: Icon(Icons.remove_red_eye,
                            color: isObscured ? Colors.blue : Colors.grey),
                      )),
                ),
                const SizedBox(height: 30),
                CustomButton(
                    title: 'Register',
                    callBack: () {
                      if (_formkey.currentState!.validate()) {
                        _formkey.currentState!.save();
                        try {
                          auth.signUp(_emailController.text.trim(),
                              _passwordController.text.trim());
                          logger.d(auth.currentUser?.email);
                          Navigator.of(context).pushReplacementNamed(homeRoute);
                        } on FirebaseAuthException catch (e) {
                          setState(() {
                            errorMessage = e.message;
                          });
                        }
                      }
                    }),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(loginRoute);
                        },
                        child: const Text('Login')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
