import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:registration_app/screens/LoginScreen.dart';
import 'package:registration_app/screens/RegistrationScreen.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Registration App'),
      ),
      body: new Center(
        child: new ButtonBar(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new RaisedButton(
                child: new Text("Register"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistrationScreen()),
                  );
                }),
            new RaisedButton(
                child: new Text("Login"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                })
          ],
        ),
      ),
    );
  }
}
