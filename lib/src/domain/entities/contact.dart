import 'package:cloud_firestore/cloud_firestore.dart';

class Contact {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phoneNumber;
  final String imageUrl;

  Contact(this.id, this.firstName, this.lastName, this.imageUrl, this.email,
      this.phoneNumber, this.password);

  Contact.fromJson(DocumentSnapshot<Map<String, dynamic>> json)
      : id = json.id,
        firstName =
            json['firstName'] == null ? '' : json['firstName'] as String,
        lastName = json['lastName'] == null ? '' : json['lastName'] as String,
        email = json['email'] == null ? '' : json['email'] as String,
        password = json['password'] == null ? '' : json['password'] as String,
        phoneNumber =
            json['phoneNumber'] == null ? '' : json['phoneNumber'] as String,
        imageUrl = json['imageUrl'] == null ? '' : json['imageUrl'] as String;
}
