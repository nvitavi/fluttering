import 'package:registration_app/model/user.dart';
import 'package:registration_app/db/login_request.dart';

abstract class SaveCallBack {
  void onSaveSuccess(int result);
  void onError(String error);
}

class SaveResponse {
  SaveCallBack _callBack;
  LoginRequest loginRequest = new LoginRequest();
  SaveResponse(this._callBack);

  doSave(String firstName, String lastName, String password, String image) {
    loginRequest
        .saveUser(firstName, lastName, password, image)
        .then((result) => _callBack.onSaveSuccess(result))
        .catchError((onError) => _callBack.onError(onError.toString()));
  }
}