import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divemate/screens/singledive_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:divemate/screens/login_screen.dart';
import '../database.dart';
import '../models.dart';
import '../widgets/widgets_for_lists.dart';

class DiveLogsScreen extends StatefulWidget {
  static final String id = 'divelogs_screen';

  @override
  _DiveLogsScreen createState() => _DiveLogsScreen();
}

class _DiveLogsScreen extends State<DiveLogsScreen> {
  final db = DatabaseService();
  int numDives = 0;
  Map<String, dynamic> testDive = {
    'location': 'TEST & CAICOS',
    'img': 'LINK_TO_IMG',
    'comment': 'Comment here',
  };

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    if (user == null) {
      return LoginScreen();
    }

    return Material(
      child: Container(
        child: StreamBuilder<List<Dive>>(
          stream: db.streamDives(user),
          builder: (context, snapshot) {
            var dives = snapshot.data;
            if (dives?.isNotEmpty ?? false) {
              // makes sure the data is not null
              return Scaffold(
                //backgroundColor: const Color(0xffecf0f1),
                body: customListViewDives(dives, user, context),
                floatingActionButton: floatingButton(
                    (){ //db.addDive(user, testDive);
                      Navigator.pushNamed(context, SingleDiveScreen.id, arguments: {"dive": {'id': db.getNewDiveId(user)}});
                    },
                    "assets/icons/log.png",
                ),
              );
            } else {
              return Scaffold(
                body: Center(
                  child: Text(
                    "Click the button below to add a new dive",
                    style: TextStyle(color: Color(0xfff6c7a89)),
                  ),
                ),
                floatingActionButton: floatingButton(
                    (){ //db.addDive(user, testDive);
                      Navigator.pushNamed(context, SingleDiveScreen.id, arguments: 
                        {"dive": {'id': db.getNewDiveId(user)}});
                    },
                  "assets/icons/log.png",
                ),
              );
              //   return Container(
              //     alignment: Alignment(0.0, 0.0),
              //     child: ElevatedButton( //separate this into a widget
              //       style: ButtonStyle(
              //         backgroundColor: MaterialStateProperty.all<Color>(Color(0xffa9cfd8)),
              //         foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
              //       ),
              //       child: Text("Add Dive"),
              //       onPressed: () => db.addDive(user, testDive),
              //     ),
              //   );
            }
          },
        ),
      ),
    );
  }
}
