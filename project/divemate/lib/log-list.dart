import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:divemate/profile.dart';
import 'package:provider/provider.dart';

class LogList extends StatefulWidget {
  @override
  _LogList createState() => _LogList();
}

class _LogList extends State<LogList> {
  final _numEntries = 10;

  _entry(int index){
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
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/turtle.jpg"),
                  )
              )
          ),
          Spacer(),
          Column(
            children: [
              Text("Log Entry ${index + 1}", style: TextStyle(fontWeight: FontWeight.bold)),
              Padding(
                padding: EdgeInsets.only(top: 25.0, bottom: 10.0),
                child: Text("I saw a cool turtle!"),
              )
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Clean up controllers when the widget is disposed.
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    // uncomment this if you need user in this widget
    var user = Provider.of<User>(context);
    return Scaffold(
      //backgroundColor: Color.fromRGBO(187, 222, 220, 1),
      // Different types of layouts we can use here; still exploring...
        body: SafeArea(
            child:
            DefaultTabController(
                length: 3,
                child: Scaffold(
                  appBar: AppBar(
                    bottom: TabBar(
                      tabs: [
                        Tab(icon: ImageIcon(AssetImage("assets/icons/log.png"))),
                        Tab(icon: ImageIcon(AssetImage("assets/icons/documents.png"))),
                        Tab(icon: Icon(Icons.account_circle_outlined)),
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      ListView.builder(
                        itemCount: this._numEntries,
                        itemBuilder: (context, index) => this._entry(index),
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