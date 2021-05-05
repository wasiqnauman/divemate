import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divemate/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

// this file is to create object class Dive from the map received from the database

class Dive {
  String id;
  String location;
  String img;
  String comment;
  String buddy;
  String purpose;
  String certificationLevel;
  String certificationCompany;
  DateTime startDatetime;

  DatabaseService _db = DatabaseService();

  Dive(User user){
    this.id = _db.getNewDiveId(user);
  }
  Dive.fromId(this.id, {this.location, this.img, this.comment, this.startDatetime, this.buddy, this.purpose, this.certificationCompany, this.certificationLevel});

  factory Dive.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data();

    Dive d = Dive.fromId(
      doc.id,
      location: data['location'] ?? '',
      img: data['img'] ?? '',
      comment: data['comment'] ?? '',
      startDatetime: data['startDatetime'].toDate(),
      buddy: data['buddy'] ?? '',
      purpose: data['purpose'] ?? '',
      certificationCompany: data['certificationCompany'] ?? '',
      certificationLevel: data['certificationLevel'] ?? '',
    );

    print("Got a dive from firebase! ${d.id} from ${d.startDatetime}");
    return d;
  }
}

class Document {
  String id;
  String name;
  String img;
  String number;
  String doctype;
  String comment;

  DatabaseService _db = DatabaseService();
  Document(this.id, {this.name, this.img, this.comment, this.number, this.doctype});
  
  Document.fresh(User user){
    this.id = _db.getNewDocumentId(user);
  }

  factory Document.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data();

    return Document(
      doc.id,
      name: data['name'] ?? '',
      img: data['img'] ?? '',
      number: data['number'] ?? '',
      doctype: data['doctype'] ?? '',
      comment: data['comment'] ?? '',
    );
  }
}