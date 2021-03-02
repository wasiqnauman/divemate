import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'models.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  
  // Future<Dive> getDive(String location) async {
  //   var snap = await _db.collection('users').doc('userid').get();
  //
  //   return Dive.fromMap(snap.data());
  // }
}