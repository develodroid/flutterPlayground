import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'splash_view.dart';

void main() {
  //Injector.configure(Flavor.PRO);
  runApp(
      new MaterialApp(
          title: 'Remind Meow',
          home: new SplashPage(),
          theme: ThemeData.light().copyWith(
            inputDecorationTheme:
            InputDecorationTheme(border: OutlineInputBorder(), fillColor: Colors.purple[400]))
      )
  );
}