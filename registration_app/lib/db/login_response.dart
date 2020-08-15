import 'dart:html';

import 'package:registration_app/model/user.dart';
import 'package:registration_app/db/login_request.dart';

abstract class LoginCallBack {
  void onLoginSuccess(User user);
  void onError(String error);
}

class LoginResponse {
  LoginCallBack _callBack;
  LoginRequest loginRequest = new LoginRequest();
  LoginResponse(this._callBack);

  doLogin(String firstName, String lastName, String password) {
    loginRequest
        .getUser(firstName, lastName, password)
        .then((user) => _callBack.onLoginSuccess(user))
        .catchError((onError) => _callBack.onError(onError.toString()));
  }
}