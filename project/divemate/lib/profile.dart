import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';
import 'package:provider/provider.dart';
import 'package:divemate/login.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}


class _ProfilePageState extends State<ProfilePage> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  void _logout() async{
    try {
      await _auth.signOut();
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return LoginPage();
          })
      );
    } catch (e) {
      print(e.message);
      Toast.show(e.message, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    //global user setup with provider package
    var user = Provider.of<User>(context);

    return Material(
        type: MaterialType.transparency,
        child: Column(
            children: [
              Spacer(flex:2),
              Text("Welcome ${user.email} \nWe kindly request \$200K",
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.blueAccent,
                ),
              ),
              Spacer(),
              Row(
                  children: [
                    Spacer(),
                    Image.asset(
                        "assets/images/spongebob-money.jpg",
                        width: MediaQuery.of(context).size.width/ 3.1
                    ),
                    Image.asset(
                        "assets/images/money.png",
                        width: MediaQuery.of(context).size.width / 3.1
                    ),
                    Image.asset(
                      "assets/images/lokesh.png",
                      width: MediaQuery.of(context).size.width / 3.1,
                    ),
                    Spacer(),
                  ]
              ),
              Spacer(),
              ElevatedButton(
                child: Text('LOGOUT'),
                style: ButtonStyle(
                  // Still exploring button styles
                ),
                onPressed: _logout,
              ),
              Spacer(flex:3),
            ]
        )
    );
  }
}