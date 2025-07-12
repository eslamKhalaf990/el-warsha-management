import 'package:flutter/material.dart';

class DefaultText extends StatelessWidget {
  const DefaultText({
    super.key,
    required this.txt,
    this.color,
    this.size,
    this.font,
    this.logo,
    this.bold, this.center,
  });

  final String txt;
  final Color? color;
  final double? size;
  final bool? font;
  final bool? logo;
  final bool? bold;
  final bool? center;

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      overflow: TextOverflow.ellipsis,
      textAlign: center == null || center == true ? TextAlign.center : TextAlign.start,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: bold == true ? FontWeight.bold : null,
      ),
    );
  }
}