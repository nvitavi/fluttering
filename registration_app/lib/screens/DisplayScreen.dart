import 'package:flutter/material.dart';
import 'package:registration_app/screens/DisplayText.dart';

class DisplayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SizedBox(
          width: 400,
          child: Card(
            child: DisplayText(),
          ),
        ),
      ),
    );
  }
}