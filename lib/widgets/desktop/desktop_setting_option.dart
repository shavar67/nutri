import 'package:flutter/material.dart';

class DesktopSettingOptions extends StatefulWidget {
  const DesktopSettingOptions({Key? key}) : super(key: key);

  @override
  State<DesktopSettingOptions> createState() => _DesktopSettingOptionsState();
}

class _DesktopSettingOptionsState extends State<DesktopSettingOptions> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: size.width,
              height: 100,
              color: Colors.white,
            )
          ],
        ),
        const Text('lorem ipsum'),
        const Text('lorem ipsum'),
      ],
    );
  }
}
