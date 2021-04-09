import 'package:divemate/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  void _logout() async {
    try {
      await _auth.signOut();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LoginScreen();
      }));
    } catch (e) {
      print(e.message);
      Toast.show(e.message, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    String subUsername = user.email.substring(0, user.email.indexOf('@'));
    String username = user.displayName != null ? user.displayName : subUsername;
    if (user == null) {
      return LoginScreen();
    }
    return Material(
      child: Container(
        child: Container(
          margin: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // container containing the user image and details
              Container(
                margin: EdgeInsets.all(10), // add margin to all sides
                child: CircleAvatar(
                  // user image avatar
                  radius: 80,
                  backgroundImage: AssetImage('assets/images/lokesh.png'),
                ),
              ),
              Text(
                // name of the user
                '$username',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text('${user.email}'), // email of the user

              // container with all the buttons
              Container(
                margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // *** ADD FUNCTION DEFINITIONS FOR THE BUTTONS ***
                    TextButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          Icons.settings,
                          color: Colors.black,
                        ),
                        label: Text(
                          "Settings",
                          style: TextStyle(color: Colors.black),
                        )),
                    TextButton.icon(
                        onPressed: () {
                          DefaultTabController.of(context).animateTo(0);
                        },
                        icon: Icon(
                          Icons.history,
                          color: Colors.black,
                        ),
                        label: Text(
                          "Dive history",
                          style: TextStyle(color: Colors.black),
                        )),
                    TextButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          Icons.attach_money,
                          color: Colors.black,
                        ),
                        label: Text(
                          "Give 200K NOW!",
                          style: TextStyle(color: Colors.black),
                        )),
                    TextButton.icon(
                        onPressed: () async =>
                            {await FirebaseAuth.instance.signOut()},
                        icon: Icon(
                          Icons.exit_to_app,
                          color: Colors.black,
                        ),
                        label: Text(
                          "Logout",
                          style: TextStyle(color: Colors.black),
                        )),
                    // ProfileButton(Icons.settings, "Settings", null),
                    // ProfileButton(Icons.history, "Dive History", null),
                    // ProfileButton(
                    //     Icons.attach_money, "Give A+ grade", null),
                    // ProfileButton(Icons.exit_to_app, "Logout", null),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileButton extends StatelessWidget {
  final IconData iconType;
  final String iconLabel;
  final Function action;
  ProfileButton(this.iconType, this.iconLabel, this.action);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Icon(iconType),
        TextButton(
            onPressed: () {},
            child: Text(
              iconLabel,
              style: TextStyle(fontSize: 18),
            )),

        // *** Use expanded widgets to avoid overflow   ***

        // Expanded(child: Icon(iconType), flex: 1),

        // Expanded(
        //   flex: 2,
        //   child: TextButton(
        //     onPressed: () => print("$iconLabel was pressed!"),
        //     child: Text(
        //       iconLabel,
        //       style: TextStyle(fontSize: 16),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
