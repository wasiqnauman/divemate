import 'dart:async';
import 'package:divemate/screens/home_screen.dart';
import 'package:divemate/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:divemate/screens/signup_screen.dart';
import 'package:toast/toast.dart';

class LoginScreen extends StatefulWidget {
  static final String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  StreamSubscription<void> _authListener;
  UserCredential _userCredential;
  final GlobalKey<FormState> _formkey = new GlobalKey<FormState>();
  String _email;
  String _password;
  final snackBar = SnackBar(content: Text("Sign in successful!"));

  _login() async {
    try {
      _userCredential = await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
    } catch (e) {
      print(e.message);
      Toast.show(e.message, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  _submit() {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      print(_email);
      print(_password);

      // Login the user here using firebase
      _login();
    }
  }

  _onAuthChange(User user) {
    if (user == null) {
      print('No user is currently signed in.');
    } else {
      print('${user.email} is signed in!');
      Toast.show("Signed in!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      Navigator.of(context).pushReplacementNamed(HomeScreen.id);
    }
  }

  void dispose() {
    // Clean up controllers when the widget is disposed.
    _authListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _authListener = _auth.authStateChanges().listen(_onAuthChange);

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
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
