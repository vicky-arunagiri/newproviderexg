import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:newproviderexg/Validate.dart';
import 'package:newproviderexg/notification_text.dart';
import 'package:newproviderexg/progress_bar.dart';
import 'package:newproviderexg/provider/auth.dart';
import 'package:newproviderexg/styles.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log In'),
        leading: Container(),
      ),
      body: Center(
        child: Container(
          child: const Padding(
            padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
            child: LogInForm(),
          ),
        ),
      ),
    );
  }
}

class LogInForm extends StatefulWidget {
  const LogInForm({Key? key}) : super(key: key);

  @override
  LogInFormState createState() => LogInFormState();
}

class LogInFormState extends State<LogInForm> {
  final formKey = GlobalKey<FormState>();

  String? email;
  String? password;
  String message = '';

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    Future<void> submit() async {
      //AuthProvider auth = Provider.of<AuthProvider>(context);
      final form = formKey.currentState;
      if (form!.validate()) {
        //showLoaderDialog(context, 'Logging..Please wait..');
        print('Data I/P email: ${email}');
        print('Data I/P password: ${password}');
        await auth.dologin(email!, password!);
      }
    }

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Log in to the App',
            textAlign: TextAlign.center,
            style: Styles.h1,
          ),
          const SizedBox(height: 10.0),
          Consumer<AuthProvider>(
            builder: (context, provider, child) =>
                provider.notification ?? NotificationText("", type: ""),
          ),
          const SizedBox(height: 30.0),
          TextFormField(
              decoration: Styles.input.copyWith(
                hintText: 'Email',
              ),
              validator: (value) {
                email = value!.trim();
                return Validate.validateEmail(value);
              }),
          const SizedBox(height: 15.0),
          TextFormField(
              obscureText: true,
              decoration: Styles.input.copyWith(
                hintText: 'Password',
              ),
              validator: (value) {
                password = value!.trim();
                return Validate.requiredField(value, 'Password is required.');
              }),
          const SizedBox(height: 15.0),
          FlatButton(
            child: const Text(
              'LogIn',
              style: TextStyle(fontSize: 20.0),
            ),
            onPressed: () {
              setState(() {
                submit();
              });
            },
          ),
          const SizedBox(height: 20.0),
          Center(
            child: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Don't have an account? ",
                  ),
                  TextSpan(
                    text: 'Register.',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => {
                            Navigator.pushNamed(context, '/register'),
                          },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          Center(
            child: RichText(
              text: TextSpan(
                  text: 'Forgot Your Password?',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => {
                          Navigator.pushNamed(context, '/password-reset'),
                        }),
            ),
          ),
        ],
      ),
    );
  }
}
