import 'package:flutter/material.dart';

class TextBubble extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;

  TextBubble(this.text,
      {this.backgroundColor = const Color(0xFF424242),
      this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 12.0),
        ),
      ),
    );
  }
}
