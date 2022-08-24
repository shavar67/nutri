import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nuclear/provider/theme_provider.dart';
import 'package:nuclear/theme/styles.dart';
import 'package:nuclear/widgets/mobile/category_list.dart';
import 'package:provider/provider.dart';

class CreateRecipeView extends StatefulWidget {
  const CreateRecipeView({Key? key}) : super(key: key);

  @override
  State<CreateRecipeView> createState() => _CreateRecipeViewState();
}

class _CreateRecipeViewState extends State<CreateRecipeView>
    with SingleTickerProviderStateMixin {
  late final _animatedCpntroller;
  bool _tapped = false;
  final double _defaultHeight = -1000;
  Logger logger = Logger(printer: PrettyPrinter());
  @override
  void initState() {
    _animatedCpntroller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final themeProvider = context.watch<ThemeProvider>();
    return Stack(
      children: [
        Positioned(
            top: 0,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Lorem Ipsum'),
                  ),
                  SizedBox(
                      width: size.width,
                      height: size.height * 0.18,
                      child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: MobileCategoryList()))
                ],
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
                      progress: _animatedCpntroller,
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
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          const Text('Recipe'),
                          const SizedBox(height: 50),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              OutlinedButton.icon(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
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
                                    backgroundColor: MaterialStateProperty.all(
                                        Styles.defaultDarkModeBg)),
                                onPressed: () {
                                  invokeEntry();
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
      _tapped = !_tapped;
      logger.i(_tapped);
    });
  }
}
