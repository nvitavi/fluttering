import 'package:flutter/material.dart';
import 'package:registration_app/model/user.dart';

class DisplayText extends StatelessWidget {

  final User user;

  DisplayText({Key key, @required this.user}) : super(key: key);

  double _lableFontSize = 20.0;
  double _valueFontSize = 15.0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: RichText(
            text: TextSpan(
                text: "First Name: ",
                style: TextStyle(fontSize: _lableFontSize, color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: user.firstName,
                      style: TextStyle(
                          fontSize: _valueFontSize,
                          color: Colors.black,
                          fontWeight: FontWeight.bold))
                ]),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: RichText(
            text: TextSpan(
                text: "Last Name: ",
                style: TextStyle(fontSize: _lableFontSize, color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: user.lastName,
                      style: TextStyle(
                          fontSize: _valueFontSize,
                          color: Colors.black,
                          fontWeight: FontWeight.bold))
                ]),
          ),
        )
      ],
    );
  }
}
