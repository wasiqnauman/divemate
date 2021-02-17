import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(187, 222, 220, 1),
      // Different types of layouts we can use here; still exploring...
      body: SafeArea(
        child: ListView(
          // ListView is needed as a wrapper to add padding and better control
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 200.0),
          children: <Widget>[
            Column(
              children: <Widget>[
                Text('Welcome!'),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                ElevatedButton(
                  child: Text('LOGIN'),
                  style: ButtonStyle(
                    // Still exploring button styles
                  ),
                  onPressed: () {
                    // TODO: Authenticate passed fields!
                  },
                ),
                ElevatedButton(
                  child: Text('SIGNUP'),
                  onPressed: () {
                    // TODO: Take to sign-up page or register passed fields!
                  },
                ),
              ],
            ),
          ]
        )
      )
    );
  }
}