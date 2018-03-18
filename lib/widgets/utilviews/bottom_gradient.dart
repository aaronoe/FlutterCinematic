import 'package:flutter/material.dart';

class BottomGradient extends StatelessWidget {

  final double offset;

  BottomGradient({this.offset: 0.95});

  BottomGradient.noOffset() : offset = 1.0;

  @override
  Widget build(BuildContext context) {
    return new DecoratedBox(
      decoration: new BoxDecoration(
          gradient: new LinearGradient(
            end: const FractionalOffset(0.0, 0.0),
            begin: new FractionalOffset(0.0, offset),
            colors: const <Color>[
              const Color(0xff222128),
              const Color(0x442C2B33),
              const Color(0x002C2B33)
            ],
          )
      ),
    );
  }
}

