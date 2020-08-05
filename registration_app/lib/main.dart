import 'package:flutter/material.dart';
import 'package:registration_app/screens/LandingPage.dart';
import 'package:registration_app/screens/LoginScreen.dart';
import 'package:registration_app/screens/RegistrationScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Registration App",
      home: LandingPage(),
      routes: {
        '/register': (context) => RegistrationScreen(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}
