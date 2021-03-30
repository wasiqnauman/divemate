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
  dynamic testDive = {'location': 'TEST & CAICOS', 'img': 'LINK_TO_IMG', 'comment': 'AWESOME TEST'};

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
            if (dives?.isNotEmpty ?? false) { // makes sure the data is not null
              return Scaffold(
                backgroundColor: const Color(0xffecf0f1),
                body: Text("WAIT"),
                floatingActionButton: floatingButton(() => db.addDive(user, testDive), "assets/icons/log.png"),
              );
            } else {
              return Container(
                alignment: Alignment(0.0, 0.0),
                child: ElevatedButton(
                  child: Text("Add Dive"),
                  onPressed: () => db.addDive(user, testDive),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}