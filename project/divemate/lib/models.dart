import 'package:cloud_firestore/cloud_firestore.dart';

// this file is to create object class Dive from the map received from the database

class Dive {
  final String id;
  final String location;
  final String img;
  final String comment;

  Dive({this.id, this.location, this.img, this.comment});

  factory Dive.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data();

    return Dive(
      id: doc.id,
      location: data['location'] ?? '',
      img: data['img'] ?? '',
      comment: data['comment'] ?? '',
    );
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