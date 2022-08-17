import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nuclear/constants/strings.dart';
import 'package:nuclear/screens/shared/auth.dart';
import 'package:provider/provider.dart';

import '../../constants/route_constants.dart';
import '../../widgets/custom/customButtons.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final bool isLogin = true;
  String? errorMessage = '';
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final _formkey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  late bool isObscured = true;
  var logger = Logger(
      printer: PrettyPrinter(
          methodCount: 8,
          lineLength: 180,
          printTime: false,
          printEmojis: true,
          colors: true));
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    logger.d('initState: LoginWidget');
  }

  String? _emailInputValidator(String? value) {
    if (value == null || value.isEmpty) {
      logger.d('email field empty');

      return 'enter your email address to continue';
    }
    if (!_emailRegex.hasMatch(value)) {
      return 'not a valid email address';
    }
    return null;
  }

  String? _passwordInputValidator(String? value) {
    if (value == null || value.isEmpty) {
      logger.d('password field empty');
      return 'enter your password to continue';
    }
    if (value.length <= 6) {
      return 'password needs to be longer than 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<Auth>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBar(title: const Text(Strings.homeTitle)),
      body: Form(
        key: _formkey,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                    height: 200,
                    width: 150,
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Login',
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
                  enableIMEPersonalizedLearning: true,
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
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                        title: 'Login',
                        callBack: () async {
                          if (_formkey.currentState!.validate()) {
                            _formkey.currentState!.save();
                            await signInWithEmailAndPassword();
                          }
                          return;
                        }),
                    const SizedBox(width: 20),
                    TextButton(
                      child: const Text('Forgot password'),
                      onPressed: () {},
                    ),
                  ],
                ),
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account?'),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(registerRoute);
                            },
                            child: const Text('Register')),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signIn(
          _emailController.text.trim(), _passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
