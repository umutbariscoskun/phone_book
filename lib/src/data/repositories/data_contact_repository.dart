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

  bool _isContactsFetched = false;

  List<Contact> _contacts = [];

  @override
  Future<void> addContact(String uid, Contact contact) async {
    try {
      _contacts.clear();
      _contacts.add(contact);

      await _firestore
          .collection("Users")
          .doc(uid)
          .collection("Contacts")
          .add(contact.toJson());

      _streamController.add(_contacts);
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future<void> addContactToFavorites(String uid, Contact contact) {
    // TODO: implement addContactToFavorites
    throw UnimplementedError();
  }

  @override
  Stream<List<Contact>> getContacts(String uid) {
    try {
      _initContacts(uid);
      return _streamController.stream;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future<void> removeContact(String uid, String contactId) {
    // TODO: implement removeContact
    throw UnimplementedError();
  }

  @override
  Future<void> removeContactFromFavorites(String uid, String contactId) {
    // TODO: implement removeContactFromFavorites
    throw UnimplementedError();
  }

  @override
  Future<List<Contact>> searchContact(String searchValue) {
    // TODO: implement searchContact
    throw UnimplementedError();
  }

  @override
  Future<void> updateContact(String uid, Contact contact) {
    // TODO: implement updateContact
    throw UnimplementedError();
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

        contacts.sort((a, b) => a.firstName.compareTo(b.lastName));
        _contacts = contacts;
        Future.delayed(Duration.zero).then(
          (_) => _streamController.add(_contacts),
        );
      }
      _isContactsFetched = true;
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
}
