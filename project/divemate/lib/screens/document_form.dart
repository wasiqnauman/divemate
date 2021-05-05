import 'dart:async';
import 'dart:io';
import 'package:divemate/database.dart';
import 'package:divemate/models.dart';
import 'package:divemate/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'login_screen.dart';

class DocumentForm extends StatefulWidget {
  static final String id = 'document_form';

  @override
  _DocumentFormState createState() => _DocumentFormState();
}

class _DocumentFormState extends State<DocumentForm> {
  final GlobalKey<FormState> _documentKey = new GlobalKey<FormState>();
  String _documentName;
  String _documentNo;
  String _comment;
  String _documentType;
  final db = DatabaseService();
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  bool _first = true;

  openFilePicker(User user, Document document) async {
    PickedFile _pi = await ImagePicker().getImage(source: ImageSource.gallery);
    if (_pi == null) {
      return;
    }
    File _image = File(_pi.path);
    Reference ref = storage.ref().child("${user.uid}/${document.id}/pics/0");
    UploadTask storageUploadTask = ref.putFile(_image);
    await storageUploadTask.whenComplete(() async {
      print('Finished uploading pic!');
      final String url = await ref.getDownloadURL();
      print("The download URL is $url");
      db.addDocument(user.uid, {"id": document.id, "img": url});
    });
  }

  void _submit(User user, String id) {
    if (_documentKey.currentState.validate()) {
      _documentKey.currentState.save();
      print(_documentName);
      print(_comment);
      DatabaseService().addDocument(user.uid, {
        'id': id,
        'name': _documentName,
        'comment': _comment,
        'number': _documentNo,
        'doctype': _documentType,
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    if (user == null) {
      return LoginScreen();
    }
    final Map<String, Document> args =
        ModalRoute.of(context).settings.arguments ??
            {"document": Document.fresh(user)};
    final Document document = args["document"];
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
                        false,
                        initVal: document.name),
                    SizedBox(
                      height: 20.0,
                    ),
                    createTextField(
                        'Document Number',
                        (input) => (input == null || input.isEmpty)
                            ? 'Dcoument number cannot be empty'
                            : null,
                        (input) => _documentNo = input,
                        false,
                        initVal: document.number),
                    createTextField(
                        'Comments',
                        (input) => (input == null || input.isEmpty)
                            ? 'Comments cannot be empty'
                            : null,
                        (input) => _comment = input,
                        false,
                        initVal: document.comment),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Document Type:'),
                        DropdownButton<String>(
                          value: _first ? document.doctype : _documentType,
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          onChanged: (String newValue) {
                            setState(() {
                              _documentType = newValue;
                            });
                            _first = false;
                          },
                          items: <String>['License', 'Gear-info', 'PR-Record']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),

                    createButton('Submit', () => _submit(user, document.id)),
                  ],
                )),
            SizedBox(
              height: 10.0,
            ),
            createButton('Upload a picture', () {
              openFilePicker(user, document);
            }),
          ],
        ),
      ),
    );
  }
}
