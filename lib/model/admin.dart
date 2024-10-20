
import 'package:cloud_firestore/cloud_firestore.dart';

class Admin {
  String? id;
  String? name;
  String? email;

  Admin({this.id, this.name, this.email});

  Admin.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    name = documentSnapshot["name"];
    email = documentSnapshot["email"];
  }

}