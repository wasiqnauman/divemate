import 'package:divemate/screens/document_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:divemate/screens/login_screen.dart';
import '../database.dart';
import '../models.dart';
import '../widgets/widgets_for_lists.dart';

class DocumentsScreen extends StatefulWidget {
  static final String id = 'documents_screen';

  @override
  _DocumentsScreen createState() => _DocumentsScreen();
}

class _DocumentsScreen extends State<DocumentsScreen> {
  final db = DatabaseService();
  dynamic testDocument = {
    'name': 'PADI LICENSE',
    'img': 'LINK_TO_IMG',
    'comment': 'PADI_ID'
  };

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    if (user == null) {
      return LoginScreen();
    }

    return Material(
      child: Container(
        child: StreamBuilder<List<Document>>(
          stream: db.streamDocuments(user),
          builder: (context, snapshot) {
            var documents = snapshot.data;
            if (documents?.isNotEmpty ?? false) {
              // makes sure the data is not null
              return Scaffold(
                //backgroundColor: const Color(0xffecf0f1),
                body: customListViewDocuments(documents, user, context),
                floatingActionButton: floatingButton(
                    () => Navigator.pushNamed(context, DocumentForm.id),
                    // () => db.addDocument(user, testDocument),
                    "assets/icons/documents.png"),
              );
            } else {
              return Scaffold(
                body: Center(
                  child: Text(
                    "Click the button below to add a new document",
                    style: TextStyle(color: Color(0xfff6c7a89)),
                  ),
                ),
                floatingActionButton: floatingButton(
                    () => Navigator.pushNamed(context, DocumentForm.id),
                    // () => db.addDocument(user, testDocument),
                    "assets/icons/documents.png"),
              );
              // return Container(
              //   alignment: Alignment(0.0, 0.0),
              //   child: ElevatedButton(
              //     child: Text("Add Document"),
              //     onPressed: () => db.addDocument(user, testDocument),
              //   ),
              // );
            }
          },
        ),
      ),
    );
  }
}
