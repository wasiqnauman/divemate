import 'package:flutter/material.dart';

import 'package:divemate/login.dart';

class DivemateApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Divemate',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.lightBlue,
      ),
      // This is so app starts in login, will change later with authentication!
      home: LoginPage(),
    );
  }
}