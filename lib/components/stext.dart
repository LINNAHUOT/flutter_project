import 'package:flutter/material.dart';

class SText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;
  SText({Key? key, this.color= const Color(0xFFccc7c5),
    required this.text,
    this.size=12,
    this.height=1.2
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'RobotoMono',
          color: color,
          fontSize: size,
          height: height,
          fontWeight: FontWeight.w400
      ),
    );
  }
}