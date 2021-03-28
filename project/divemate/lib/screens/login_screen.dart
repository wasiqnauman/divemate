import 'dart:io';
import 'package:divemate/login.dart';
import 'package:divemate/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:divemate/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  static final String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  String _email;
  String _password;

  _submit() {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      print(_email);
      print(_password);

      // Login the user here using firebase
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Divemate',
              style: TextStyle(fontFamily: 'Billabong', fontSize: 50.0),
            ),

            // create the user login/ signup form
            // create the user login/ signup form
            Form(
                key: _formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // create the email textfield
                    createTextField(
                        'Email',
                        (input) => !input.contains('@')
                            ? 'Please enter a valid email'
                            : null,
                        (input) => _email = input,
                        false),

                    // create the password textfield
                    createTextField(
                        'Password',
                        (input) => input.length < 6
                            ? 'Password must be atleast 6 characters'
                            : null,
                        (input) => _password = input,
                        true),
                    // add space
                    SizedBox(height: 20.0),

                    createButton('Login', _submit),
                    // add space
                    SizedBox(height: 20.0),

                    createButton('Signup',
                        () => Navigator.pushNamed(context, SignupScreen.id)),
                    SizedBox(height: 20.0),
                    createButton('Go to old login screen',
                        () => Navigator.pushNamed(context, LoginPage.id)),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
