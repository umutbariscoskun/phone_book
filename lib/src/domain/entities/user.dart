import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:phone_book/src/domain/entities/contact.dart';

class User {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String imageUrl;
  final List<Contact>? contacts;

  User(
    this.uid,
    this.firstName,
    this.lastName,
    this.email,
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
        phoneNumber =
            json['phoneNumber'] == null ? '' : json['phoneNumber'] as String,
        imageUrl = json['imageUrl'] == null ? '' : json['imageUrl'] as String,
        contacts = json['Contacts'] == null || json['Contacts'].length == 0
            ? <Contact>[]
            : List.from(
                json['Contacts'].map((contact) => Contact.fromJson(contact)));
}
