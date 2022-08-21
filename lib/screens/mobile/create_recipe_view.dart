import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nuclear/provider/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../theme/styles.dart';

class CreateRecipeView extends StatefulWidget {
  const CreateRecipeView({Key? key}) : super(key: key);

  @override
  State<CreateRecipeView> createState() => _CreateRecipeViewState();
}

class _CreateRecipeViewState extends State<CreateRecipeView> {
  Logger logger =
      Logger(printer: PrettyPrinter(printEmojis: true, printTime: false));
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned(
            right: 0,
            bottom: size.height * 0.1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: FloatingActionButton(
                  backgroundColor: themeProvider.getDarkTheme
                      ? Styles.greyShade900
                      : Styles.white,
                  onPressed: () async {},
                  child: Icon(
                    Icons.add,
                    color: themeProvider.getDarkTheme
                        ? Styles.defaultIconColor
                        : Colors.green,
                  )),
            ))
      ],
    );
  }
}
