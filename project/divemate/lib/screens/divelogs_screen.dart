import 'package:divemate/screens/singledive_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:divemate/screens/login_screen.dart';
import 'package:divemate/database.dart';
import 'package:divemate/models.dart';
import 'package:divemate/widgets/widgets_for_lists.dart';

class DiveLogsScreen extends StatefulWidget {
  static final String id = 'divelogs_screen';

  @override
  _DiveLogsScreen createState() => _DiveLogsScreen();
}

class _DiveLogsScreen extends State<DiveLogsScreen> {
  final db = DatabaseService();
  int numDives = 0;

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
                    (){
                      Navigator.pushNamed(context, SingleDiveScreen.id);
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
                    (){
                      Navigator.pushNamed(context, SingleDiveScreen.id);
                    },
                  "assets/icons/log.png",
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
