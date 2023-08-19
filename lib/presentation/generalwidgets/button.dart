import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MyButton extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  VoidCallback? onTap;
  Color? backColor;
  MyButton(
      {super.key,
      required this.child,
      this.height,
      this.width,
      this.onTap,
      this.backColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          fixedSize: Size(width ?? 318, height ?? 44),
          primary: backColor ?? HexColor('#0A38A7'),
          shadowColor: HexColor('#0A38A7'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: child,
        ));
  }
}
