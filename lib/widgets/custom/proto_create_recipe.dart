import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nuclear/firebase_auth/auth_service..dart';
import 'package:nuclear/provider/theme_provider.dart';
import 'package:nuclear/theme/styles.dart';
import 'package:provider/provider.dart';

import '../../database/databse.dart';

class CreateRecipeView extends StatefulWidget {
  const CreateRecipeView({Key? key}) : super(key: key);

  @override
  State<CreateRecipeView> createState() => _CreateRecipeViewState();
}

class _CreateRecipeViewState extends State<CreateRecipeView>
    with SingleTickerProviderStateMixin {
  late final _animatedController;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late TextEditingController _productNameController,
      _authorNameController,
      _descController,
      _ingredientController;
  late String? _uid;

  bool _tapped = false;
  final double _defaultHeight = -1000;
  Logger logger = Logger(printer: PrettyPrinter());

  @override
  void initState() {
    _productNameController = TextEditingController();
    _authorNameController = TextEditingController();
    _descController = TextEditingController();
    _ingredientController = TextEditingController();
    _animatedController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    super.initState();
  }

  @override
  void dispose() {
    _ingredientController.dispose();
    _descController.dispose();
    _authorNameController.dispose();
    _productNameController.dispose();
    super.dispose();
  }

  String? _fieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      logger.d('Cannot be empty');

      return 'Enter product description to continue';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final themeProvider = context.watch<ThemeProvider>();
    final authProvider = context.read<AuthService>();
    _uid = authProvider.currentUser!.uid;
    return Stack(
      children: [
        Positioned(
            top: 0,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Lorem Ipsum'),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            )),
        _tapped
            ? const Positioned(
                bottom: 0,
                child: SizedBox(),
              )
            : Positioned(
                bottom: size.height * 0.1,
                right: 20,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: FloatingActionButton(
                    backgroundColor: themeProvider.getDarkTheme
                        ? Styles.greyShade900
                        : Styles.white,
                    child: AnimatedIcon(
                      color: themeProvider.getDarkTheme
                          ? Styles.lightBgColor
                          : Styles.defaultDarkModeBg,
                      icon: _tapped
                          ? AnimatedIcons.close_menu
                          : AnimatedIcons.add_event,
                      progress: _animatedController,
                    ),
                    onPressed: () {
                      invokeEntry();
                    },
                  ),
                )),
        _tapped
            ? AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                bottom: _tapped ? size.height * 0.25 : _defaultHeight,
                left: size.width * 0.0275,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                      width: size.width * 0.95,
                      height: size.height * 0.60,
                      color: themeProvider.getDarkTheme
                          ? Styles.greyShade900
                          : Styles.white,
                      child: Form(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SizedBox(height: 50),
                            const Text('New Recipe'),
                            const SizedBox(height: 20),
                            SizedBox(
                                width: size.width * 0.8,
                                child: TextFormField(
                                  controller: _authorNameController,
                                  keyboardType: TextInputType.name,
                                  validator: _fieldValidator,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      label: Text('Enter your name')),
                                )),
                            const SizedBox(height: 20),
                            SizedBox(
                                width: size.width * 0.8,
                                child: TextFormField(
                                  controller: _productNameController,
                                  keyboardType: TextInputType.text,
                                  validator: _fieldValidator,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      label: Text('Enter product name')),
                                )),
                            const SizedBox(height: 20),
                            SizedBox(
                                width: size.width * 0.8,
                                child: TextFormField(
                                  controller: _descController,
                                  keyboardType: TextInputType.text,
                                  validator: _fieldValidator,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      label: Text('Enter product description')),
                                )),
                            const SizedBox(height: 20),
                            SizedBox(
                                width: size.width * 0.8,
                                child: TextField(
                                  textInputAction: TextInputAction.done,
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                  controller: _ingredientController,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      label: Text('Enter ingredients')),
                                )),
                            const SizedBox(height: 20),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OutlinedButton.icon(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.black)),
                                  icon: const Icon(Icons.close,
                                      color: Colors.white),
                                  onPressed: () {
                                    invokeEntry();
                                  },
                                  label: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: AutoSizeText(
                                      'Dismiss',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                OutlinedButton.icon(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Styles.defaultDarkModeBg)),
                                  onPressed: () {
                                    logger.i(
                                        'name: ${_authorNameController.text} product name: ${_productNameController.text} product descr: ${_descController.text} ingredients: ${_ingredientController.text.split(',')} ');
                                    addRecipe(
                                        _productNameController.text,
                                        _descController.text,
                                        _authorNameController.text,
                                        _ingredientController.text,
                                        authProvider.currentUser!.uid);
                                  },
                                  icon: const Icon(Icons.add_task_outlined,
                                      color: Colors.white),
                                  label: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: AutoSizeText(
                                      'Submit',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10)
                          ],
                        ),
                      )),
                ))
            : AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                bottom: _tapped ? size.height * 0.25 : _defaultHeight,
                left: size.width * 0.0275,
                child: SizedBox(
                  width: size.width * 0.95,
                  height: size.height * 0.45,
                )),
      ],
    );
  }

  void invokeEntry() {
    setState(() {
      logger.i(
          'name: ${_authorNameController.text} product name: ${_productNameController.text} product descr: ${_descController.text} ingredients: ${_ingredientController.text.split(',')} ');
      _tapped = !_tapped;
    });
  }

  void resetEntryFields() {
    _ingredientController.clear();
    _descController.clear();
    _authorNameController.clear();
    _productNameController.clear();
  }
}
