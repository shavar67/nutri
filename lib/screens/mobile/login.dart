import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nuclear/model/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../firebase_auth/auth_service..dart';

class MobileLoginView extends StatefulWidget {
  const MobileLoginView({Key? key}) : super(key: key);

  @override
  State<MobileLoginView> createState() => _MobileLoginViewState();
}

class _MobileLoginViewState extends State<MobileLoginView> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();
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
    logger.d('initState: MobileLoginView');
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
    final authService = context.watch<AuthService>();
    final themeProvider = context.watch<ThemeProvider>();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        body: Consumer(
          builder: ((context, value, child) {
            return Stack(
              children: [
                Positioned(
                  top: 0,
                  child: Form(
                    key: _formKey,
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32),
                      )),
                      width: size.width,
                      height: size.height * 0.5,
                      child: const Center(child: Text('insert logo here')),
                    ),
                  ),
                ),
                Positioned(
                    top: size.height * 0.30,
                    left: size.width * 0.05,
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      width: size.width * 0.90,
                      height: size.height * 0.5,
                      child: Column(children: [
                        const SizedBox(height: 20),
                        const AutoSizeText(
                          'Sign In',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 26),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: size.width * 0.8,
                          child: TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: _emailInputValidator,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text('Enter your Email')),
                          ),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: size.width * 0.8,
                          child: TextFormField(
                            controller: _passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: isObscured,
                            obscuringCharacter: '*',
                            validator: _passwordInputValidator,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() => isObscured = !isObscured);
                                  },
                                  icon: Icon(Icons.remove_red_eye,
                                      color: isObscured
                                          ? Colors.blue
                                          : Colors.grey),
                                ),
                                border: const OutlineInputBorder(),
                                label: const Text('Enter your password')),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            // Foreground color
                            onPrimary: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                            // Background color
                            primary: Colors.blue,
                          ).copyWith(
                              elevation: ButtonStyleButton.allOrNull(0.0)),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                            }
                            await authService.signIn(_emailController.text,
                                _passwordController.text);
                          },
                          child: Container(
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                              ),
                              height: 30,
                              width: size.width * 0.7,
                              child: const Align(
                                  alignment: Alignment.center,
                                  child: AutoSizeText(
                                    'Submit',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ))),
                        ),
                        GestureDetector(
                          onTap: () {
                            logger.i('method invoked');
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 28),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  Text(
                                    'Forgot',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    'password?',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ]),
                    ))
              ],
            );
          }),
        ));
  }
}
