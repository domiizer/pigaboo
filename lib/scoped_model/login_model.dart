import 'package:pigaboo/model/Login.dart';
import 'package:scoped_model/scoped_model.dart';

class loginmodel extends Model {
  Login _currentUser;

  void logined(Login user) {
    _currentUser = user;
  }

  Login get currentUser {
    return _currentUser;
  }
}
