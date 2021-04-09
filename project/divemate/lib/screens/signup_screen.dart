import 'dart:async';

import 'package:divemate/screens/documents_screen.dart';
import 'package:divemate/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class SignupScreen extends StatefulWidget {
  static final id = 'signup_screen';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  StreamSubscription<void> _authListener;
  UserCredential _userCredential;

  final _formkey = GlobalKey<FormState>();
  String _email;
  String _password;
  String _name;

  _signup() async {
    try {
      _userCredential = await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
    } catch (e) {
      print(e.message);
      Toast.show(e.message, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  _onSuccess(User user) async {
    // yikes very sketchy
    await _auth.signOut();
    await _auth.signInWithEmailAndPassword(email: _email, password: _password);

    print('${user.displayName} is signed in!');
    Toast.show("Signed in!", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      return DocumentsScreen();
    }), (_) => false);
  }

  _update(User user) async {
    await user.updateProfile(
      displayName: _name,
    );
  }

  void _onAuthChange(User user) {
    if (user == null) {
      print('No user is currently signed in.');
    } else {
      _update(user).then((s) => _onSuccess(user)).catchError((e) => print(e));
    }
  }

  void dispose() {
    // Clean up controllers when the widget is disposed.
    _authListener.cancel();
    super.dispose();
  }

  _submit() {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      print(_name);
      print(_email);
      print(_password);
      // login the user here
      _signup();
    }
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
            Form(
                key: _formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // create the name textfield
                    createTextField(
                        'Name',
                        (input) => input.trim().isEmpty
                            ? 'Please enter a valid name'
                            : null,
                        (input) => _name = input,
                        false),

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

                    createButton('Signup', _submit),
                    // add space
                    SizedBox(height: 20.0),

                    createButton('Back to login', () => Navigator.pop(context)),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
