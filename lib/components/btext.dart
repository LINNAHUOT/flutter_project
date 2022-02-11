import 'package:flutter/material.dart';

class BText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  BText({Key? key, this.color= const Color(0xFF332d2b ),
    required this.text,
    this.size=25,
    this.overflow=TextOverflow.ellipsis
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
          fontFamily: 'samantha',
          fontSize: size,
          color: color,
          fontWeight: FontWeight.bold
      ),
    );
  }
}
