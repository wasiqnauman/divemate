import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'models.dart';

// this file creates interface for the database
// here is reference: https://firebase.flutter.dev/docs/overview

// NOTE: to get a users image and properly save it to our database
// we need to use a combination of cloud storage (to store the pic)
// and the link to that image will be stored in cloud firestore
// reference: https://firebase.google.com/docs/storage

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  
  Stream<List<Dive>> streamDives(User user) {
    var ref = _db.collection('users').doc(user.uid).collection('dives-list');
    
    return ref.snapshots().map((list) =>
      list.docs.map((doc) => Dive.fromFireStore(doc)).toList());
  }

  Stream<List<Document>> streamDocuments(User user) {
    var ref = _db.collection('users').doc(user.uid).collection('documents-list');

    return ref.snapshots().map((list) =>
        list.docs.map((doc) => Document.fromFireStore(doc)).toList());
  }

  // dives should be added as objects
  Future<void> addDive(User user, dynamic dive) {
    return _db
        .collection('users')
        .doc(user.uid)
        .collection('dives-list')
        .add(dive);
  }

  Future<void> addDocument(User user, dynamic document) {
    return _db
        .collection('users')
        .doc(user.uid)
        .collection('documents-list')
        .add(document);
  }

  Future<void> removeDive(User user, String id) {
    return _db
        .collection('users')
        .doc(user.uid)
        .collection('dives-list')
        .doc(id)
        .delete();
  }
  
  Future<void> removeDocument(User user, String id) {
    return _db
        .collection('users')
        .doc(user.uid)
        .collection('documents-list')
        .doc(id)
        .delete();
  }
}