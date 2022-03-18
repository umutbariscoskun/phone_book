import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:phone_book/src/data/helpers/upload_helper.dart';
import 'package:phone_book/src/domain/entities/contact.dart';
import 'package:phone_book/src/domain/repositories/contact_repository.dart';
import 'package:phone_book/src/domain/types/enums/storage_bucket_type.dart';

class DataContactRepository implements ContactRepository {
  static final _instance = DataContactRepository._internal();
  DataContactRepository._internal() : _firestore = FirebaseFirestore.instance;
  factory DataContactRepository() => _instance;

  final FirebaseFirestore _firestore;

  StreamController<List<Contact>> _streamController =
      StreamController.broadcast();

  StreamController<List<Contact>> _favoritedsStreamController =
      StreamController.broadcast();

  bool _isContactsFetched = false;

  List<Contact> _contacts = [];
  List<Contact> _favoritedContacts = [];

  @override
  Stream<List<Contact>> getContacts(String uid) {
    try {
      if (!_isContactsFetched) _initContacts(uid);

      Future.delayed(Duration.zero)
          .then((value) => _streamController.add(_contacts));

      return _streamController.stream;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future<void> removeContact(String uid, String contactId) async {
    try {
      final CollectionReference collectionReference =
          _firestore.collection("Users").doc(uid).collection("Contacts");

      await collectionReference.doc(contactId).delete();

      _contacts.removeWhere((element) => element.id == contactId);
      _contacts.sort((a, b) =>
          a.firstName.toLowerCase().compareTo(b.firstName.toLowerCase()));

      _streamController.add(_contacts);
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future<void> updateContactInformation(
      String uid, Contact editedContact) async {
    try {
      final CollectionReference collectionReference =
          _firestore.collection("Users").doc(uid).collection("Contacts");

      collectionReference.doc(editedContact.id).set({
        'firstName': editedContact.firstName,
        'lastName': editedContact.lastName,
        'imageUrl': editedContact.imageUrl,
        'email': editedContact.email,
        'phoneNumber': editedContact.phoneNumber,
        'isFavorited': editedContact.isFavorited,
      }, SetOptions(merge: true));

      int index =
          _contacts.indexWhere((contact) => contact.id == editedContact.id);
      _contacts[index].firstName = editedContact.firstName;
      _contacts[index].lastName = editedContact.lastName;
      _contacts[index].imageUrl = editedContact.imageUrl;
      _contacts[index].email = editedContact.email;
      _contacts[index].phoneNumber = editedContact.phoneNumber;
      _contacts[index].isFavorited = editedContact.isFavorited;

      Future.delayed(Duration.zero)
          .then((value) => _streamController.add(_contacts));
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  void _initContacts(String uid) async {
    try {
      if (_isContactsFetched) return;
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection("Users")
          .doc(uid)
          .collection("Contacts")
          .get();

      if (snapshot.docs.isNotEmpty) {
        List<Contact> contacts = [];

        snapshot.docs.forEach((doc) {
          contacts.add(Contact.fromJson(doc));
        });

        contacts.sort((a, b) =>
            a.firstName.toLowerCase().compareTo(b.firstName.toLowerCase()));
        _contacts = contacts;

        Future.delayed(Duration.zero).then(
          (_) => _streamController.add(_contacts),
        );
        _isContactsFetched = true;
      }
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future<String> uploadContactImageToStorage(
      String imagePath, String imageName, StorageBucketType storageType) async {
    try {
      String url = await UploadHelper()
          .uploadImageToStorage(imagePath, imageName, storageType);
      return url;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future<void> addContactToFavorites(String uid, Contact contact) async {
    try {
      int index = _contacts.indexWhere((element) => element.id == contact.id);

      _contacts[index].isFavorited = true;

      _streamController.add(_contacts);

      await _firestore
          .collection("Users")
          .doc(uid)
          .collection("Contacts")
          .doc(contact.id)
          .set(
        {'isFavorited': true},
        SetOptions(merge: true),
      );
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future<void> removeContactFromFavorites(String uid, String contactId) async {
    try {
      int index = _contacts.indexWhere((element) => element.id == contactId);

      _contacts[index].isFavorited = false;

      _streamController.add(_contacts);

      final CollectionReference collectionReference =
          _firestore.collection("Users").doc(uid).collection("Contacts");

      await collectionReference.doc(contactId).set(
        {'isFavorited': false},
        SetOptions(merge: true),
      );
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future<List<Contact>> searchContact(String searchValue) async {
    try {
      List<Contact> searchedContacts = [];

      for (int index = 0; index < _contacts.length; index++) {
        if (_contacts[index].firstName.contains(searchValue) ||
            _contacts[index].phoneNumber.contains(searchValue) ||
            _contacts[index].lastName.contains(searchValue) ||
            _contacts[index].email.contains(searchValue)) {
          searchedContacts.add(_contacts[index]);
        }
      }
      return searchedContacts;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future<void> addContact(String uid, String firstName, String lastName,
      String downloadUrl, String email, String phoneNumber) async {
    try {
      String _contactId = "";
      await _firestore.collection("Users").doc(uid).collection("Contacts").add({
        "firstName": firstName,
        "lastName": lastName,
        "downloadUrl": downloadUrl,
        "email": email,
        "phoneNumber": phoneNumber,
        'isFavorited': false,
      }).then((value) => _contactId = value.id);

      Contact createdContact = Contact(
        id: _contactId,
        firstName: firstName,
        lastName: lastName,
        imageUrl: downloadUrl,
        email: email,
        phoneNumber: phoneNumber,
        isFavorited: false,
      );

      _contacts.add(createdContact);
      _contacts.sort((a, b) =>
          a.firstName.toLowerCase().compareTo(b.firstName.toLowerCase()));

      _streamController.add(_contacts);
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }
}
