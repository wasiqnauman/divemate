import 'dart:async';
import 'dart:io';

import 'package:divemate/screens/documents_screen.dart';
import 'package:divemate/screens/home_screen.dart';
import 'package:divemate/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'package:path_provider/path_provider.dart';

class SignupScreen extends StatefulWidget {
  static final id = 'signup_screen';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  StreamSubscription<void> _authListener;
  UserCredential _userCredential;

  final _formkey = GlobalKey<FormState>();
  String _email;
  String _password;
  String _name;
  Image _profilePic = Image.asset('assets/icons/default_pic.jpeg');
  String _profilePicPath = 'assets/icons/default_pic.jpeg';
  // bool is_signup = false;

  final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  _signup() async {
    try {
      _userCredential = await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);

      Reference ref = storage.ref().child("${_userCredential.user.uid}/profilePic");
      UploadTask storageUploadTask = ref.putFile(File(_profilePicPath));
      if(_profilePicPath != 'assets/icons/default_pic.jpeg'){
        await storageUploadTask.whenComplete(() async{
          print('Finished uploading pic!');
          final String url = await ref.getDownloadURL();
          print("The download URL is $url");
          _userCredential.user.updateProfile(photoURL: url);
        });
      }
      print('${_userCredential.user.displayName} signed up!');
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
        return HomeScreen();
      }), (_) => false);
    } catch (e) {
      print(e.message);
      Toast.show(e.message, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

    }
  }

  // _onSuccess(User user) async {
  //   if(is_signup){
  //     return;
  //   }
  //   await _auth.signOut();
  //   await _auth.signInWithEmailAndPassword(email: _email, password: _password);
  //   print('${user.displayName} is signed in!');
  //   Toast.show("Signed in!", context,
  //       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
  //     return DocumentsScreen();
  //   }), (_) => false);
  // }

  // _update(User user) async {
  //   await user.updateProfile(
  //     displayName: _name,
  //   );
  // }

  // void _onAuthChange(User user) {
  //   if (user == null) {
  //     print('No user is currently signed in.');
  //   } else {
  //     _update(user).then((s) => _onSuccess(user)).catchError((e) => print(e));
  //   }
  // }

  // void dispose() {
  //   // Clean up controllers when the widget is disposed.
  //   _authListener.cancel();
  //   super.dispose();
  // }

  _submit() {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      print(_name);
      print(_email);
      print(_password);
      // login the user here
      _signup();
    }
  }

  @override
  Widget build(BuildContext context) {
    // _authListener = _auth.authStateChanges().listen(_onAuthChange);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Divemate',
              style: TextStyle(fontFamily: 'Billabong', fontSize: 50.0),
            ),

            // create the user login/ signup form
            Form(
                key: _formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // Circle for profile picture
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text("Click below to upload your profile picture!"),
                    ),
                    Container(
                      child: GestureDetector(
                          onTap: () async{
                            PickedFile pic = await ImagePicker().getImage(source: ImageSource.gallery);
                            if(pic != null){
                              setState(() {
                                _profilePic = Image.file(File(pic.path));
                                _profilePicPath = pic.path;
                              });
                            }
                          },
                          child: CircleAvatar(
                            radius: 80,
                            backgroundImage: _profilePic.image,
                        ),
                      ),
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        border: new Border.all(
                          color: Colors.blue.withAlpha(200),
                          width: 2.0,
                        ),
                      ),
                    ),
                    // create the name textfield
                    createTextField(
                        'Name',
                        (input) => input.trim().isEmpty
                            ? 'Please enter a valid name'
                            : null,
                        (input) => _name = input,
                        false),

                    // create the email textfield
                    createTextField(
                        'Email',
                        (input) => !input.contains('@')
                            ? 'Please enter a valid email'
                            : null,
                        (input) => _email = input,
                        false),

                    // create the password textfield
                    createTextField(
                        'Password',
                        (input) => input.length < 6
                            ? 'Password must be atleast 6 characters'
                            : null,
                        (input) => _password = input,
                        true),
                    // add space
                    SizedBox(height: 20.0),

                    createButton('Signup', _submit),
                    // add space
                    SizedBox(height: 20.0),

                    createButton('Back to login', () => Navigator.pop(context)),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
