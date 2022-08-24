import 'package:flutter/material.dart';

class MobileCategoryList extends StatelessWidget {
  const MobileCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    color: Colors.deepPurpleAccent,
                  ),
                  width: 250));
        });
  }
}
