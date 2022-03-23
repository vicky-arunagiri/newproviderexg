// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:newproviderexg/homepage.dart';
import 'package:newproviderexg/loading.dart';
import 'package:newproviderexg/login.dart';
import 'package:newproviderexg/model/user_model.dart';
import 'package:newproviderexg/progress_bar.dart';
import 'package:newproviderexg/provider/auth.dart';
import 'package:newproviderexg/provider/user_provider.dart';
import 'package:newproviderexg/route.dart';
import 'package:newproviderexg/shared_preference.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Future<UserModel> getUserData() => SharedPreference().getUser();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => AuthProvider()),
        ChangeNotifierProvider(
            create: (BuildContext context) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: getUserData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              default:
                if (snapshot.hasError) {
                  return Text('Error1: ${snapshot.error}');
                } else if (snapshot.data.token == null) {
                  return LogingStatus(context);
                } else {
                  Provider.of<UserProvider>(context).setUser(snapshot.data);
                  return const MyHomePage();
                }
            }
          },
        ),
      ),
    );
  }
}

Widget LogingStatus(BuildContext context) {
  switch (context.watch<AuthProvider>().status) {
    case Status.Authenticating:
      return Loading();
    case Status.Authenticated:
      return const MyHomePage();
    case Status.Unauthenticated:
      return const LoginPage();
    default:
      return const LoginPage();
  }
}
