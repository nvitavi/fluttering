
class User {
  int _id;
  String _firstName;
  String _lastName;
  String _password;
  String _image;


  User(this._firstName, this._lastName, this._password, this._image);

  User.fromMap(dynamic obj) {
    this._firstName = obj['firstName'];
    this._lastName = obj['lastName'];
    this._password = obj['password'];
    this._image = obj['image'];
  }

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get password => _password;
  String get image => _image;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["firstName"] = _firstName;
    map["lastName"] = _lastName;
    map["password"] = _password;
    map["image"] = _image;
    return map;
  }
}