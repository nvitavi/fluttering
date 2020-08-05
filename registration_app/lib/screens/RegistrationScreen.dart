import 'package:flutter/material.dart';
import 'package:registration_app/screens/RegistrationForm.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SizedBox(
          width: 400,
          child: Card(
            child: RegistrationForm(),
          ),
        ),
      ),
    );
  }
}
