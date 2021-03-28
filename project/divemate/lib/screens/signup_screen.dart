import 'package:divemate/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  static final id = 'signup_screen';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formkey = GlobalKey<FormState>();
  String _email;
  String _password;
  String _name;

  _submit() {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      print(_name);
      print(_email);
      print(_password);
      // login the user here
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
