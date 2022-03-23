import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:newproviderexg/model/user_model.dart';
import 'package:newproviderexg/notification_text.dart';
import 'package:newproviderexg/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthProvider with ChangeNotifier {
  Status _status = Status.Unauthenticated;
  String? _token;
  NotificationText? _notification;

  Status get status => _status;
  String? get token => _token;
  NotificationText? get notification => _notification;

  final SharedPref = SharedPreference();
  static const String baseUrl =
      'http://restapi.adequateshop.com/api/authaccount/';

  static const String LOGIN = baseUrl + '/login';

  initAuthProvider() async {
    String? token = await SharedPref.getToken();
    if (token != null) {
      _token = token;
      _status = Status.Authenticated;
    } else {
      _status = Status.Unauthenticated;
    }
    notifyListeners();
  }

  Future<bool> dologin(String email, String password) async {
    //var result;
    _status = Status.Authenticating;
    _notification = null;
    notifyListeners();
    print('Api I/p ');
    Map<String, dynamic> loginData = {'email': email, 'password': password};
    print('Api I/p 123');
    try {
      http.Response response = await post(
        Uri.parse('http://restapi.adequateshop.com/api/authaccount/login'),
        body: json.encode(loginData),
        headers: {'Content-Type': 'application/json'},
      );
      print('Apiresponse--' + response.statusCode.toString());
      if (response.statusCode == 200) {
        final Map<String, dynamic> apiResponse = json.decode(response.body);

        var userData = apiResponse['data'];
        var message = apiResponse['message'];

        if (userData != null) {
          UserModel authUser = UserModel.fromJson(userData);
          print('--Load authUser--' + authUser.toString());
          await SharedPref.saveUser(authUser);

          _status = Status.Authenticated;

          notifyListeners();

          return true;
        } else {
          _status = Status.Unauthenticated;
          _notification = NotificationText(
            'Invalid email or password.',
            type: '',
          );
          notifyListeners();

          return false;
        }
      }
      _status = Status.Unauthenticated;
      _notification = NotificationText(
        'Server error.',
        type: '',
      );
      notifyListeners();
      return false;
    } catch (e) {
      throw Exception('Failed');
    }
  }

  /* Future<String?> getToken() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String? token = storage.getString('token');
    return token;
  }

  storeUserData(apiResponse) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString('token', apiResponse['Token']);
    await storage.setString('email', apiResponse['Email']);
    await storage.setString('name', apiResponse['Name']);
  }*/
}
