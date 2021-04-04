import 'package:divemate/database.dart';
import 'package:divemate/screens/login_screen.dart';
import 'package:divemate/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DocumentForm extends StatefulWidget {
  static final String id = "document_form";
  @override
  _DocumentFormState createState() => _DocumentFormState();
}

class _DocumentFormState extends State<DocumentForm> {
  final _formkey = GlobalKey<FormState>();
  List<String> _documentTypes = ['License', 'Diver-ID', 'Other'];
  static final String _defaultDropDownValue = 'Choose document type';
  String _documentName;
  String _comments;
  String _dropdownValue = 'License';
  final db = DatabaseService();

  _submit(User user) {
    if (_formkey.currentState != null && _formkey.currentState.validate()) {
      _formkey.currentState.save();
      print(_documentName);
      print(_comments);
      print(_dropdownValue);
      // db.addDocument(user, {'name': _documentName, 'comment': _comments});
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    if (user == null) {
      return LoginScreen();
    }
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Add a new document'.toUpperCase(),
            style: TextStyle(fontSize: 18.0),
          ),
          Form(
              key: _formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  createTextField(
                      'Name of document',
                      (input) => (input == null || input.isEmpty)
                          ? 'Name cant be empty'
                          : null,
                      (input) => _documentName = input,
                      false),
                  createTextField(
                      'Comments',
                      (input) => (input == null || input.isEmpty)
                          ? 'Comments cant be empty'
                          : null,
                      (input) => _comments,
                      false),
                  Container(
                    width: 250.0,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: Text('Choose document type'),
                      //value: _dropdownValue,
                      elevation: 16,
                      style: TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          _dropdownValue = newValue;
                        });
                      },
                      items: _documentTypes
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  createButton('Submit', _submit(user)),
                ],
              ))
        ],
      )),
    );
  }
}
