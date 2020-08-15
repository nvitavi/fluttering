import 'dart:async';

import 'package:registration_app/model/user.dart';
import 'package:registration_app/db/login_controller.dart';

class LoginRequest {
  LoginCtr con = new LoginCtr();

  Future<int> saveUser(String firstName, String lastName, String password, String image) {
    var result = con.saveUser(new User(firstName, lastName, password, image));
    return result;
  }

  Future<User> getUser(String firstName, String lastName, String password) {
    var result = con.getLogin(firstName, lastName, password);
    return result;
  }
}