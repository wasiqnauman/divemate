import 'dart:async';
import 'package:divemate/screens/login_screen.dart';
import 'package:divemate/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:divemate/log-list.dart';

class LoginPage extends StatefulWidget {
  static final id = "login_page";
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  StreamSubscription<void> _authListener;
  UserCredential _userCredential;

  void _login() async {
    try {
      _userCredential = await _auth.signInWithEmailAndPassword(
          email: _usernameCtrl.text, password: _passwordCtrl.text);
    } catch (e) {
      print(e.message);
      Toast.show(e.message, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  void _signup() async {
    try {
      _userCredential = await _auth.createUserWithEmailAndPassword(
          email: _usernameCtrl.text, password: _passwordCtrl.text);
    } catch (e) {
      print(e.message);
      Toast.show(e.message, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  void _onAuthChange(User user) {
    if (user == null) {
      print('No user is currently signed in.');
    } else {
      print('${user.email} is signed in!');
      Toast.show("Signed in!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return LogList();
      }), (_) => false);
    }
  }

  @override
  void dispose() {
    // Clean up controllers when the widget is disposed.
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
    _authListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // this _authListener can be replaced with the provider package in the future
    // this is beacuse provider already has the stream with the authentication state
    // this might be making it do it double, seeing it repeat in the console
    _authListener = _auth.authStateChanges().listen(_onAuthChange);

    return Scaffold(
        //backgroundColor: Color.fromRGBO(187, 222, 220, 1),
        // Different types of layouts we can use here; still exploring...
        body: SafeArea(
            child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/ocean.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 175, 20, 200),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(169, 169, 169, 0.8),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  child: ListView(
                      // ListView is needed as a wrapper to add padding and better control
                      padding: EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 40.0),
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Row(children: [
                              Spacer(),
                              Text(
                                'Divemate',
                                style: GoogleFonts.lato(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Spacer(),
                            ]),
                            TextField(
                              controller: _usernameCtrl,
                              decoration: InputDecoration(
                                labelText: 'Username',
                              ),
                            ),
                            TextField(
                              controller: _passwordCtrl,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Password',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
                              child: ElevatedButton(
                                child: Text('LOGIN'),
                                style: ButtonStyle(
                                    // Still exploring button styles
                                    ),
                                onPressed: _login,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.all(1.0),
                                child: ElevatedButton(
                                  child: Text('SIGNUP'),
                                  onPressed: _signup,
                                )),
                            createButton(
                                'Go to new Login Screen',
                                () => Navigator.pushNamed(
                                    context, LoginScreen.id)),
                          ],
                        ),
                      ]),
                ))));
  }
}
