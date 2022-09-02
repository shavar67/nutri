import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nuclear/provider/theme_provider.dart';
import 'package:nuclear/theme/styles.dart';
import 'package:provider/provider.dart';

class RecipeForm extends StatefulWidget {
  const RecipeForm({Key? key}) : super(key: key);

  @override
  State<RecipeForm> createState() => _RecipeFormState();
}

class _RecipeFormState extends State<RecipeForm> {
  bool _tapped = false;
  final double _defaultHeight = -1000;
  Logger logger = Logger(printer: PrettyPrinter());
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final Size size = MediaQuery.of(context).size;
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
            left: 10,
            bottom: _tapped ? size.height * 0.25 : _defaultHeight,
            duration: const Duration(milliseconds: 500),
            child: Container(
              width: size.width * 0.95,
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
                      // const AutoSizeText('New Recipe'),
                      // const SizedBox(height: 20),
                      // TextFormField(
                      //   decoration: const InputDecoration(
                      //       labelText: 'Enter your name',
                      //       border: OutlineInputBorder(
                      //           borderRadius:
                      //               BorderRadius.all(Radius.circular(20)))),
                      // ),
                      // const SizedBox(height: 20),
                      // TextFormField(
                      //   decoration: const InputDecoration(
                      //       labelText: 'Enter recipe name',
                      //       border: OutlineInputBorder(
                      //           borderRadius:
                      //               BorderRadius.all(Radius.circular(20)))),
                      // ),
                      // const SizedBox(height: 20),
                      // TextFormField(
                      //     decoration: const InputDecoration(
                      //         labelText: 'Enter recipe description',
                      //         border: OutlineInputBorder(
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(20))))),
                      // const SizedBox(
                      //   height: 20,
                      //   child: Text('Enter recipe ingredients'),
                      // ),
                      // const TextField(
                      //     maxLines: 4,
                      //     textInputAction: TextInputAction.done,
                      //     keyboardType: TextInputType.text,
                      //     decoration: InputDecoration(
                      //         label: Text(''),
                      //         border: OutlineInputBorder(
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(20))))),
                      // const SizedBox(height: 30),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     IconButton(
                      //       onPressed: () {},
                      //       iconSize: 32,
                      //       icon: const Icon(Icons.delete_outlined),
                      //     ),

                      Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          iconSize: 32,
                          onPressed: () {
                            invokeEntry();
                          },
                          icon: const Icon(Icons.close),
                        ),
                      )
                      //   ],
                      // )
                    ],
                  ),
                ),
              )),
            ))
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
}
