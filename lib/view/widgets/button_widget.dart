import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Function? onPressed;
  final Widget? child;
  final Color? color;

  ButtonWidget({this.child, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.06,
      child: ButtonTheme(
          buttonColor: color,
          minWidth: MediaQuery.of(context).size.width,
          child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: color,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100))),
              onPressed: () => onPressed,
              child: child!)),
    );
  }
}
