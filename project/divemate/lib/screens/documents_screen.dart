import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:divemate/screens/login_screen.dart';
import '../database.dart';
import '../models.dart';

class DocumentsScreen extends StatefulWidget {
  static final String id = 'documents_screen';

  @override
  _DocumentsScreen createState() => _DocumentsScreen();
}

class _DocumentsScreen extends State<DocumentsScreen> {
  final db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    if (user == null) {
      return LoginScreen();
    }

    return Material(
      child: Container(
        color: const Color(0xffecf0f1),
        child: StreamBuilder<List<Document>>(
          stream: db.streamDocuments(user),
          builder: (context, snapshot) {
            var documents = snapshot.data;
            if (documents?.isNotEmpty ?? false) { // makes sure the data is not null
              return Column(
                children: [
                  Text('Adding a Nice list tomorrow 3/30\n Might add something in widgets folder'),
                ],
              );
            } else {
              return Container(
                alignment: Alignment(0.0, 0.0),
                child: ElevatedButton(
                  child: Text("Add Document"),
                  onPressed: () => db.addDocument(user, {
                    'name': 'PADI License',
                    'img': 'DOC image',
                    'comment': 'DOC comment'
                  }),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}