import 'package:flutter/material.dart';
import 'package:signin_example/SignUpScreen.dart';
import 'package:signin_example/WelcomeScreen.dart';


void main() => runApp(SignUpApp());

class SignUpApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => SignUpScreen(),
        '/welcome': (context) => WelcomeScreen(),
      },
    );
  }
}