import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'models.dart';

// this file creates interface for the database
// here is reference: https://firebase.flutter.dev/docs/overview

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  
  Stream<List<Dive>> streamDives(User user) {
    var ref = _db.collection('dives').doc(user.uid).collection('list');
    
    return ref.snapshots().map((list) =>
      list.docs.map((doc) => Dive.fromFireStore(doc)).toList());
  }

  // dives should be added as objects
  Future<void> addDive(User user, dynamic dive) {
    return _db
        .collection('dives')
        .doc(user.uid)
        .collection('list')
        .add(dive);
  }

  Future<void> removeDive(User user, String id) {
    return _db
        .collection('dives')
        .doc(user.uid)
        .collection('list')
        .doc(id)
        .delete();
  }
}