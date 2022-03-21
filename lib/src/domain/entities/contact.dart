import 'package:cloud_firestore/cloud_firestore.dart';

class Contact {
  final String id;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String imageUrl;
  bool isFavorited;

  Contact(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.imageUrl,
      required this.email,
      required this.phoneNumber,
      this.isFavorited = false});

  Contact.fromJson(
    DocumentSnapshot<Map<String, dynamic>> json,
  )   : id = json.id,
        firstName =
            json['firstName'] == null ? '' : json['firstName'] as String,
        lastName = json['lastName'] == null ? '' : json['lastName'] as String,
        email = json['email'] == null ? '' : json['email'] as String,
        phoneNumber =
            json['phoneNumber'] == null ? '' : json['phoneNumber'] as String,
        imageUrl = json['imageUrl'] == null ? '' : json['imageUrl'] as String,
        isFavorited = json['isFavorited'];

  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phoneNumber": phoneNumber,
      "imageUrl": imageUrl,
      "isFavorited": false,
    };
  }
}
