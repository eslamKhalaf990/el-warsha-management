import 'package:flutter/material.dart';

Widget buildCell(String text, {int flex = 2, bool isBold = false}) {
  return Expanded(
    flex: flex,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
      child: Text(
        text,
        style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
        overflow: TextOverflow.ellipsis,
      ),
    ),
  );
}
