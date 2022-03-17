import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:phone_book/src/domain/entities/contact.dart';

class User {
  final String uid;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String imageUrl;

  User(
    this.uid,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.imageUrl,
  );

  User.fromJson(DocumentSnapshot<Map<String, dynamic>> json)
      : uid = json.id,
        firstName =
            json['firstName'] == null ? '' : json['firstName'] as String,
        lastName = json['lastName'] == null ? '' : json['lastName'] as String,
        email = json['email'] == null ? '' : json['email'] as String,
        phoneNumber =
            json['phoneNumber'] == null ? '' : json['phoneNumber'] as String,
        imageUrl = json['imageUrl'] == null ? '' : json['imageUrl'] as String;
}
