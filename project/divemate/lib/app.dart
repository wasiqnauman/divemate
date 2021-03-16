import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// Page imports
import 'package:divemate/login.dart';
import 'package:provider/provider.dart';

/*
* NOTEEEEEE
* This page is super messy but dont worry about it now,
* switched using the FutureBuilder Here with just
* initializng the Firbase App in main.dart
*
* * this is where I got the reference: https://stackoverflow.com/questions/63492211/no-firebase-app-default-has-been-created-call-firebase-initializeapp-in
CHECK IT OUT IF YOURE CURIOUS
* */

class DivemateApp extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  //final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
      // Initialize FlutterFire:
      // future: _initialization,
      // builder: (context, snapshot) {
        // Check for errors
        /*if (snapshot.hasError) {
          return MaterialApp(
            builder: (BuildContext context, Widget widget) {
            Widget error = Text('...rendering error...');
            if (widget is Scaffold || widget is Navigator)
              error = Scaffold(body: Center(child: error));
            ErrorWidget.builder = (FlutterErrorDetails errorDetails) => error;
            return widget;
          },
        );
        }*/

        // Once complete, show your application
        //if (snapshot.connectionState == ConnectionState.done) {
        // MultiProvider is what allows the stream to be available from anywhere
        return MultiProvider(
          providers: [
            StreamProvider<User>.value(
              value: FirebaseAuth.instance.authStateChanges()
            )
          ],
          child: MaterialApp(
            title: 'Divemate',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              // This is the theme of your application.
              primarySwatch: Colors.lightBlue,
            ),
            // This is so app starts in login, will change later with authentication!
            home: LoginPage(),
          ),
        );

        //}

        // Otherwise, show something whilst waiting for initialization to complete
        //return Loading();
      }
    // );
  }
// }
