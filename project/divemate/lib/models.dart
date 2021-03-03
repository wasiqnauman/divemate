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