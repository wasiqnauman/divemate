// import 'package:cloud_firestore/cloud_firestore.dart';

// this file is to create object class Dive from the map received from the database

class Dive {
  final String location;
  final String img;
  final String comment;

  Dive({this.location, this.img, this.comment});

  factory Dive.fromMap(Map data) {
    return Dive(
      location: data['location'] ?? '',
      img: data['img'] ?? '',
      comment: data['comment'] ?? '',
    );
  }
}