import 'package:newproviderexg/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  Future<bool> saveUser(UserModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('email', user.name);
    prefs.setString('name', user.email);
    prefs.setString('token', user.token);
    return prefs.commit();
  }

  Future<UserModel> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var email = prefs.getString("email");
    var name = prefs.getString("name");
    var token = prefs.getString("token");
    return UserModel(email: email, name: name, token: token);
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    prefs.remove('name');
    prefs.remove('token');
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token")!;
    return token;
  }
}
