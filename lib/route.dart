import 'package:flutter/material.dart';
import 'package:newproviderexg/homepage.dart';
import 'package:newproviderexg/login.dart';

class Routes {
  static const String Route_Login = "/login";
  static const String Route_MyHomePage = "/dashboard";

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      Routes.Route_Login: (context) => const LoginPage(),
      Routes.Route_MyHomePage: (context) => const MyHomePage()
    };
  }
}
