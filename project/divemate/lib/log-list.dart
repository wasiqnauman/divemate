import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:toast/toast.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:divemate/profile.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'database.dart';
import 'models.dart';
import 'package:divemate/login.dart';

class LogList extends StatefulWidget {
  @override
  _LogList createState() => _LogList();
}

class _LogList extends State<LogList> {
  final db = DatabaseService();

  @override
  void dispose() {
    // Clean up controllers when the widget is disposed.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    if (user == null) {
      return LoginPage();
    }
    /* The tab bar view below is a bit messy but we can extract
      each inidvidual dive tile as a widget to clean it up later.
      There migh also be a problem witht he double scaffold at the top of
      this page but we can look at it later
    */
    return Scaffold(
        //backgroundColor: Color.fromRGBO(187, 222, 220, 1),
        // Different types of layouts we can use here; still exploring...
        body: SafeArea(
            child: DefaultTabController(
                length: 3,
                child: Scaffold(
                  appBar: AppBar(
                    bottom: TabBar(
                      tabs: [
                        Tab(
                            icon:
                                ImageIcon(AssetImage("assets/icons/log.png"))),
                        Tab(
                            icon: ImageIcon(
                                AssetImage("assets/icons/documents.png"))),
                        Tab(icon: Icon(Icons.account_circle_outlined)),
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      StreamBuilder<List<Dive>>(
                        stream: db.streamDives(user),
                        builder: (context, snapshot) {
                          var dives = snapshot.data;
                          if (dives != null) {
                            return Column(
                              children: [
                                SizedBox(
                                  child:
                                  ElevatedButton(
                                    child: Text("Add Dive"),
                                    onPressed: () =>
                                        db.addDive(user, {'location':'Miami', 'img':'users image','comment':'users comment'}),
                                  ),
                                ),
                                Expanded(
                                  child:
                                  ListView(
                                    shrinkWrap: true,
                                    children: dives.map((dive) {
                                      return Container(
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(169,169,169, 0.8),
                                              border: Border.all(
                                                color: Colors.black,
                                                width: 3,
                                              )
                                          ),
                                          margin: const EdgeInsets.only(left:15.0, right:15.0, top:10.0, bottom:10.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                alignment: Alignment.topLeft,
                                                width: 100,
                                                height: 100,
                                                //padding: EdgeInsets.only(top:100.0, left:100.0, right:100.0),
                                                child: Text(dive.img),
                                                // decoration: BoxDecoration(
                                                //     image: DecorationImage(
                                                //       image: AssetImage("assets/images/turtle.jpg"),
                                                //     )
                                                // )
                                              ),
                                              Spacer(),
                                              Column(
                                                children: [
                                                  Text("${dive.location}", style: TextStyle(fontWeight: FontWeight.bold)),
                                                  Padding(
                                                    padding: EdgeInsets.only(top: 25.0, bottom: 10.0),
                                                    child: Text(dive.comment),
                                                  ),
                                                  ElevatedButton(
                                                    child: Text("Delete"),
                                                    onPressed: () =>
                                                        db.removeDive(user, dive.id),
                                                  ),
                                                ],
                                              ),
                                              Spacer(),
                                            ],
                                          )
                                      );
                                    }).toList(),
                                  )
                                ),
                              ]
                            );
                          } else {
                            return Container(
                              alignment: Alignment(0.0,0.0),
                              child: ElevatedButton(
                                child: Text("Add Dive"),
                                onPressed: () =>
                                    db.addDive(user, {'location':'Miami', 'img':'users image','comment':'users comment'}),
                              ),
                            );
                          }
                        },
                      ),
                      ImageIcon(AssetImage("assets/icons/documents.png")),
                      ProfilePage(),
                    ],
                  ),
                )
            )
        )
    );
  }
}
