import 'package:flutter/material.dart';
import 'package:registration_app/screens/DisplayScreen.dart';
import 'package:registration_app/screens/AnimatedProgressIndicator.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationForm createState() => _RegistrationForm();
}

class _RegistrationForm extends State<RegistrationForm> {
  void _showDisplayScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DisplayScreen()),
    );
  }

  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final _firstNameTextController = TextEditingController();
  final _lastNameTextController = TextEditingController();
  final _imageTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _confirmTextController = TextEditingController();

  double _formProgress = 0;

  void _updateFormProgress() {
    var progress = 0.0;
    var controllers = [
      _firstNameTextController,
      _lastNameTextController,
      _imageTextController,
      _passwordTextController,
      _confirmTextController
    ];

    for (var controller in controllers) {
      if (controller.value.text.isNotEmpty) {
        progress += 1 / controllers.length;
      }
    }

    setState(() {
      _formProgress = progress;
    });

    // To validate password field
    _form.currentState.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      onChanged: _updateFormProgress,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedProgressIndicator(value: _formProgress),
          Text('Sign up', style: Theme.of(context).textTheme.headline4),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _firstNameTextController,
              decoration: InputDecoration(hintText: 'First name'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _lastNameTextController,
              decoration: InputDecoration(hintText: 'Last name'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              obscureText: true,
              controller: _passwordTextController,
              decoration: InputDecoration(hintText: 'Password'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
                obscureText: true,
                controller: _confirmTextController,
                decoration: InputDecoration(hintText: 'Confirm Password'),
                validator: (val) {
                  if (val.isEmpty) return 'Empty';
                  if (val != _passwordTextController.text) return 'Passwords need to match';
                  return null;
                }),
          ),
          FlatButton(
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: _formProgress == 1 ? _showDisplayScreen : null,
            child: Text('Sign up'),
          ),
        ],
      ),
    );
  }
}
