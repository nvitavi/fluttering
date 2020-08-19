import 'package:flutter/material.dart';
import 'package:registration_app/model/user.dart';
import 'package:registration_app/screens/DisplayText.dart';

class DisplayScreen extends StatelessWidget {

  final User user;

  DisplayScreen({Key key, @required this.user}) : super(key: key);

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
            child: DisplayText(user: user),
          ),
        ),
      ),
    );
  }
}