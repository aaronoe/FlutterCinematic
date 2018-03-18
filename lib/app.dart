import 'package:flutter/material.dart';
import 'package:movies_flutter/widgets/home_page.dart';

class CinematicApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Cinematic',
      theme: new ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: new HomePage(),
    );
  }

}