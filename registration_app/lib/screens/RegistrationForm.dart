import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:registration_app/screens/AnimatedProgressIndicator.dart';
import 'package:registration_app/model/user.dart';
import 'package:registration_app/db/save_response.dart';

import 'DisplayScreen.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationForm createState() => _RegistrationForm();
}

class _RegistrationForm extends State<RegistrationForm>
    implements SaveCallBack {
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
      //_imageTextController,
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
    //_form.currentState.validate();
  }

  BuildContext _ctx;
  bool _isLoading = false;
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  String _firstName, _lastName, _password, _image;

  SaveResponse _response;

  _RegistrationForm() {
    _response = new SaveResponse(this);
  }

  void _submit() {
    final form = _form.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _response.doSave(_firstName, _lastName, _password);
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
          /*Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                showImage(),
                RaisedButton(
                  child: Text("Select Image from Gallery"),
                  onPressed: () {
                    pickImageFromGallery(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),*/
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
                onSaved: (val) => _password = val,
                validator: (val) {
                  if (val.isEmpty) return 'Empty';
                  if (val != _passwordTextController.text)
                    return 'Passwords need to match';
                  return null;
                }),
          ),
          FlatButton(
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: _formProgress == 1 ? _submit : null,
            child: Text('Sign up'),
          ),
        ],
      ),
    );
  }

  Future<File> imageFile;

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Image.file(
            snapshot.data,
            width: 300,
            height: 300,
          );
        } else if (snapshot.error != null) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  @override
  void onError(String error) {
    print("error occurred in db: " + error);
  }

  @override
  void onSaveSuccess(User result) {
    if(result != null){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DisplayScreen(user: result)),
      );
    } else {

    }
  }

/*  @override
  void onError(String error) {
    print(error);
    *//*_showSnackBar(error);
    setState(() {
      _isLoading = false;
    });*//*
  }

  @override
  void onSaveSuccess(int result) async {
    print("success on screen");
    //if (result > 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    //}
  }*/
}
