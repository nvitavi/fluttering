import 'package:flutter/material.dart';
import 'package:registration_app/screens/AnimatedProgressIndicator.dart';
import 'package:registration_app/screens/DisplayScreen.dart';
import 'package:registration_app/model/user.dart';
import 'package:registration_app/db/login_response.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginForm createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> implements LoginCallBack {

  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final _firstNameTextController = TextEditingController();
  final _lastNameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  double _formProgress = 0;

  void _updateFormProgress() {
    var progress = 0.0;
    var controllers = [
      _firstNameTextController,
      _lastNameTextController,
      _passwordTextController,
    ];

    for (var controller in controllers) {
      if (controller.value.text.isNotEmpty) {
        progress += 1 / controllers.length;
      }
    }

    setState(() {
      _formProgress = progress;
    });
  }

  BuildContext _ctx;
  bool _isLoading = false;
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  String _firstName, _lastName, _password;

  LoginResponse _response;

  _LoginForm() {
    _response = new LoginResponse(this);
  }

  void _submit() {
    final form = _form.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _response.doLogin(_firstName, _lastName, _password);
      });
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    return Form(
      key: _form,
      onChanged: _updateFormProgress,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
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
                  onSaved: (val) => _firstName = val,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _lastNameTextController,
                  decoration: InputDecoration(hintText: 'Last name'),
                  onSaved: (val) => _lastName = val,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: true,
                  controller: _passwordTextController,
                  decoration: InputDecoration(hintText: 'Password'),
                  onSaved: (val) => _password = val,
                ),
              ),
              FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: _formProgress == 1 ? _submit : null,
                child: Text('Login'),
              ),
            ],
          ),
        );
      }),
    );
  }

  @override
  void onError(String error) {
    print("error occurred in db: " + error);
    //_showSnackBar("Login Failed!");
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSuccess(User user) {
    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DisplayScreen(user: user)),
      );
    } else {
      print("Login Failed!");
      _showSnackBar("Login Failed!");
      setState(() {
        _isLoading = false;
      });
    }
  }
}
