import 'package:flutter/material.dart';
import 'package:movies_flutter/app.dart';
import 'package:movies_flutter/scoped_models/app_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  runApp(new ScopedModel<AppModel>(
      model: new AppModel(sharedPreferences), child: new CinematicApp()));
}
