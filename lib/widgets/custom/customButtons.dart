import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.callBack, required this.title})
      : super(key: key);

  final VoidCallback callBack;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: callBack,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
          decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 1.5,
                    offset: Offset(-10, 0),
                    spreadRadius: 0,
                    color: Colors.red),
                BoxShadow(
                    blurRadius: 1.5,
                    offset: Offset(10, 0),
                    spreadRadius: 0,
                    color: Colors.blue)
              ],
              borderRadius: BorderRadius.all(Radius.circular(12)),
              color: Colors.white),
          width: 100,
          height: 35,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
            ),
          ),
        ));
  }
}
