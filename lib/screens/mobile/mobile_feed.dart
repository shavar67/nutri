import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class MobileFeed extends StatefulWidget {
  const MobileFeed({Key? key}) : super(key: key);

  @override
  State<MobileFeed> createState() => _MobileFeedState();
}

class _MobileFeedState extends State<MobileFeed> {
  Logger logger = Logger();
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: const [
        Text('lorem ipsum'),
      ]),
    );
  }
}
