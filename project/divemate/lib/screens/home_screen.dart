import 'package:divemate/screens/divelogs_screen.dart';
import 'package:divemate/screens/documents_screen.dart';
import 'package:divemate/screens/login_screen.dart';
import 'package:divemate/screens/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../database.dart';

class HomeScreen extends StatefulWidget {
  static final String id = 'home_screen';

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
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
      return LoginScreen();
    }

    return Scaffold(
        body: SafeArea(
            child: DefaultTabController(
                length: 3,
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Theme.of(context).canvasColor,
                    title: Text(
                      'Divemate',
                      style: TextStyle(fontFamily: 'Billabong', fontSize: 38.0),
                    ),
                    centerTitle: true,
                  ),
                  bottomNavigationBar: TabBar(
                    tabs: [
                      Tab(icon: ImageIcon(AssetImage("assets/icons/log.png"))),
                      Tab(
                          icon: ImageIcon(
                              AssetImage("assets/icons/documents.png"))),
                      Tab(icon: Icon(Icons.account_circle_outlined)),
                    ],
                  ),
                  body: TabBarView(
                    children: [
                      DiveLogsScreen(),
                      DocumentsScreen(),
                      UserProfile(),
                    ],
                  ),
                )
            )
        )
    );
  }
}
