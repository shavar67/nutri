import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';
import 'package:nuclear/provider/theme_provider.dart';
import 'package:nuclear/theme/styles.dart';
import 'package:provider/provider.dart';

import '../../database/databse.dart';
import '../../firebase_auth/auth_service..dart';

class RecipeForm extends StatefulWidget {
  const RecipeForm({Key? key}) : super(key: key);

  @override
  State<RecipeForm> createState() => _RecipeFormState();
}

class _RecipeFormState extends State<RecipeForm> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late TextEditingController _productNameController,
      _authorNameController,
      _descController,
      _ingredientController;
  late String? _uid;
  @override
  void initState() {
    _productNameController = TextEditingController();
    _authorNameController = TextEditingController();
    _descController = TextEditingController();
    _ingredientController = TextEditingController();

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

  bool _tapped = false;
  final double _defaultHeight = -1000;
  Logger logger = Logger(printer: PrettyPrinter());
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final Size size = MediaQuery.of(context).size;
    final authProvider = context.read<AuthService>();
    _uid = authProvider.currentUser!.uid;
    return Stack(
      children: [
        AnimatedPositioned(
            curve: Curves.decelerate,
            bottom: size.height * 0.12,
            right: !_tapped ? size.width * 0.03 : -100,
            duration: const Duration(milliseconds: 500),
            child: FloatingActionButton(
              backgroundColor: themeProvider.getDarkTheme
                  ? Styles.defaultIconColor
                  : Styles.white,
              child: Icon(
                Icons.add,
                color: themeProvider.getDarkTheme
                    ? Styles.white
                    : Styles.defaultIconColor,
              ),
              onPressed: () {
                invokeEntry();
              },
            )),
        AnimatedPositioned(
            curve: Curves.decelerate,
            left: size.width * 0.05,
            bottom: _tapped ? size.height * 0.25 : _defaultHeight,
            duration: const Duration(milliseconds: 500),
            child: Container(
                width: size.width * 0.90,
                height: size.height * 0.60,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: themeProvider.getDarkTheme
                        ? Styles.greyShade900
                        : Styles.white),
                child: Form(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                        const Center(child: AutoSizeText('New Recipe')),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _authorNameController,
                          decoration: const InputDecoration(
                              labelText: 'Name',
                              alignLabelWithHint: true,
                              hintStyle: TextStyle(fontSize: 12),
                              hintText: 'Lorem ipsum'),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _productNameController,
                          decoration: const InputDecoration(
                              labelText: 'Recipe Name',
                              alignLabelWithHint: true,
                              hintStyle: TextStyle(fontSize: 12),
                              hintText: 'Lorem ipsum'),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                            controller: _descController,
                            decoration: const InputDecoration(
                                labelText: 'Recipe Description',
                                alignLabelWithHint: true,
                                hintStyle: TextStyle(fontSize: 12),
                                hintText: 'Lorem ipsum')),
                        TextField(
                            controller: _ingredientController,
                            maxLines: 4,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                                labelText: 'Ingredients',
                                alignLabelWithHint: true,
                                hintStyle: TextStyle(fontSize: 12),
                                hintText: 'Ex: lorem,lorem,ipsum')),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Align(
                              alignment: Alignment.bottomRight,
                              child: CloseButton(
                                color: Colors.red,
                                onPressed: () {
                                  resetEntryFields();
                                },
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                await addRecipe(
                                    _productNameController.text,
                                    _descController.text,
                                    _authorNameController.text,
                                    _ingredientController.text,
                                    authProvider.currentUser!.uid);

                                EasyLoading.showSuccess(
                                    'recipe added to journal');
                                resetEntryFields();
                              },
                              iconSize: 32,
                              icon: const Icon(
                                Icons.post_add_outlined,
                                color: Colors.blue,
                              ),
                            ),
                            //   ],
                            // )
                          ],
                        ),
                      ])),
                ))))
      ],
    );
  }

  void invokeEntry() {
    setState(() {
      // logger.i(
      //     'name: ${_authorNameController.text} product name: ${_productNameController.text} product descr: ${_descController.text} ingredients: ${_ingredientController.text.split(',')} ');
      _tapped = !_tapped;
    });
  }

  void resetEntryFields() {
    _ingredientController.clear();
    _descController.clear();
    _authorNameController.clear();
    _productNameController.clear();
    invokeEntry();
  }
}
