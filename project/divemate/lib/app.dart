import 'package:divemate/screens/document_form.dart';
import 'package:divemate/screens/home_screen.dart';
import 'package:divemate/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// Page imports
import 'package:divemate/screens/signup_screen.dart';
import 'package:divemate/screens/singledive_screen.dart';
import 'package:provider/provider.dart';
import 'package:divemate/theme.dart';

class DivemateApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // MultiProvider is what allows the stream to be available from anywhere
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(
            value: FirebaseAuth.instance.authStateChanges())
      ],
      child: MaterialApp(
        title: 'Divemate',
        theme: appTheme(),
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
        // home: LoginScreen(),
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          DocumentForm.id: (context) => DocumentForm(),
          HomeScreen.id: (context) => HomeScreen(),
          SingleDiveScreen.id: (context) => SingleDiveScreen(),
        },
      ),
    );
  }
}
