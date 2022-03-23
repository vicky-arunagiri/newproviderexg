import 'package:flutter/cupertino.dart';
import 'package:newproviderexg/model/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel _user = UserModel();

  UserModel get user => _user;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }
}
