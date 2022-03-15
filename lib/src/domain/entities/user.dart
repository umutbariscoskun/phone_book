import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:phone_book/src/domain/entities/contact.dart';

class User {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phoneNumber;
  final String imageUrl;
  final List<Contact> contacts;

  User(
    this.uid,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.phoneNumber,
    this.imageUrl,
    this.contacts,
  );

  User.fromJson(DocumentSnapshot<Map<String, dynamic>> json)
      : uid = json.id,
        firstName =
            json['firstName'] == null ? '' : json['firstName'] as String,
        lastName = json['lastName'] == null ? '' : json['lastName'] as String,
        email = json['email'] == null ? '' : json['email'] as String,
        password = json['password'] == null ? '' : json['password'] as String,
        phoneNumber =
            json['phoneNumber'] == null ? '' : json['phoneNumber'] as String,
        imageUrl = json['imageUrl'] == null ? '' : json['imageUrl'] as String,
        contacts = List<Contact>.from(
            json['contacts'].map((contact) => Contact.fromJson(contact)));
}
