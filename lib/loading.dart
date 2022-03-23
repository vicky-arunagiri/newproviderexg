import 'package:flutter/material.dart';
import 'package:newproviderexg/provider/auth.dart';

import 'package:provider/provider.dart';

class Loading extends StatelessWidget {
  initAuthProvider(context) async {
    Provider.of<AuthProvider>(context).initAuthProvider();
  }

  @override
  Widget build(BuildContext context) {
    initAuthProvider(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Loading....Page'),
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
            child: new CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
