import 'dart:async';

import 'package:registration_app/model/user.dart';
import 'package:registration_app/db/login_controller.dart';

class LoginRequest {
  LoginCtr con = new LoginCtr();

  Future<User> saveUser(String firstName, String lastName, String password, String image) {
    con.saveUser(new User(firstName, lastName, password, image));
    return getUser(firstName, lastName, password);
  }

  Future<User> getUser(String firstName, String lastName, String password) {
    var result = con.getLogin(firstName, lastName, password);
    return result;
  }
}