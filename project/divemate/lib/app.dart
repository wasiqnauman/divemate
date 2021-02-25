import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// Page imports
import 'package:divemate/login.dart';
import 'package:divemate/log-list.dart';


class DivemateApp extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {

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
          return MaterialApp(
            title: 'Divemate',
            theme: ThemeData(
              // This is the theme of your application.
              primarySwatch: Colors.lightBlue,
            ),
            // This is so app starts in login, will change later with authentication!
            home: LogList(),
          );
        //}

        // Otherwise, show something whilst waiting for initialization to complete
        //return Loading();
      },
    );


  }
}