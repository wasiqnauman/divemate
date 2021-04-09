import 'dart:async';
import 'package:divemate/screens/home_screen.dart';
import 'package:divemate/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:divemate/screens/signup_screen.dart';
import 'package:toast/toast.dart';

class DocumentForm extends StatefulWidget {
  static final String id = 'document_form';

  @override
  _DocumentFormState createState() => _DocumentFormState();
}

class _DocumentFormState extends State<DocumentForm> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  StreamSubscription<void> _authListener;
  final GlobalKey<FormState> _documentKey = new GlobalKey<FormState>();
  String _documentName;
  String _comment;
  String _documentType;

  void dispose() {
    // Clean up controllers when the widget is disposed.
    super.dispose();
  }

  void _submit() {
    if (_documentKey.currentState.validate()) {
      _documentKey.currentState.save();
      print(_documentName);
      print(_comment);
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
              'Add a new document',
              style: TextStyle(fontFamily: 'Billabong', fontSize: 50.0),
            ),

            // create the user login/ signup form
            // create the user login/ signup form
            Form(
                key: _documentKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // create the document name textfield
                    createTextField(
                        'Document name',
                        (input) => (input == null || input.isEmpty)
                            ? 'Document name cannot be empty'
                            : null,
                        (input) => _documentName = input,
                        false),
                    SizedBox(
                      height: 20.0,
                    ),
                    createTextField(
                        'Comments',
                        (input) => (input == null || input.isEmpty)
                            ? 'Comments cannot be empty'
                            : null,
                        (input) => _comment = input,
                        false),
                    ElevatedButton(
                        onPressed: () => _submit(), child: Text("submit")),
                    // // create the password textfield
                    // createTextField(
                    //     'Comment',
                    //     (input) => input.length < 6
                    //         ? 'Password must be atleast 6 characters'
                    //         : null,
                    //     (input) => _comment = input,
                    //     true),
                    // // add space
                    // SizedBox(height: 20.0),

                    // createButton('Add document', _submit()),
                    // // add space
                    // SizedBox(height: 20.0),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
