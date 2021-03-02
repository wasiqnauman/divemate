import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:divemate/app.dart';

// using async and intialize app here because it stops error that was before!!
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DivemateApp());
}


