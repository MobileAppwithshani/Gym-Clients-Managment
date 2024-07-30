import 'package:flutter/material.dart';
import 'package:local_db/Screens/splash_screen.dart'; // Import your SplashScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local DB',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: SplashScreen(), // Change this to SplashScreen
    );
  }
}
