
import 'package:api_implementation/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Favorite Books',
      theme: ThemeData(
        scaffoldBackgroundColor
            : Colors.white,
      ),
      home: WelcomeScreen(),
    );
  }
}

