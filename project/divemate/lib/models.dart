import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divemate/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

// this file is to create object class Dive from the map received from the database

class Dive {
  String id;
  String location;
  String img;
  String comment;
  DateTime startDatetime;

  DatabaseService _db = DatabaseService();

  Dive(User user){
    this.id = _db.getNewDiveId(user);
  }
  Dive.fromId(this.id, {this.location, this.img, this.comment, this.startDatetime});

  factory Dive.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data();

    Dive d = Dive.fromId(
      doc.id,
      location: data['location'] ?? '',
      img: data['img'] ?? '',
      comment: data['comment'] ?? '',
      startDatetime: data['startDatetime'].toDate() ?? DateTime.now(),
    );

    print("Got a dive from firebase! ${d.id} from ${d.startDatetime}");
    return d;
  }
}

class Document {
  final String id;
  final String name;
  final String img;
  final String comment;

  Document({this.id, this.name, this.img, this.comment});

  factory Document.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data();

    return Document(
      id: doc.id,
      name: data['name'] ?? '',
      img: data['img'] ?? '',
      comment: data['comment'] ?? '',
    );
  }
}