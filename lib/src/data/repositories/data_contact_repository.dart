import 'dart:async';

import 'package:phone_book/src/data/helpers/upload_helper.dart';
import 'package:phone_book/src/domain/entities/contact.dart';
import 'package:phone_book/src/domain/repositories/contact_repository.dart';
import 'package:phone_book/src/domain/types/enums/storage_bucket_type.dart';

class DataContactRepository implements ContactRepository {
  static final _instance = DataContactRepository._internal();
  DataContactRepository._internal();
  factory DataContactRepository() => _instance;

  StreamController<List<Contact>> _streamController =
      StreamController.broadcast();

  List<Contact> _contacts = [
    Contact(
      id: "1",
      firstName: "afirstName",
      lastName: "lastName",
      imageUrl: "https://randomuser.me/api/portraits/women/59.jpg",
      email: "email@gmail.com",
      phoneNumber: "phoneNumber",
    ),
    Contact(
      id: "1",
      firstName: "afirstName",
      lastName: "lastName",
      imageUrl: "https://randomuser.me/api/portraits/women/59.jpg",
      email: "email@gmail.com",
      phoneNumber: "phoneNumber",
    ),
    Contact(
      id: "1",
      firstName: "afirstName",
      lastName: "lastName",
      imageUrl: "https://randomuser.me/api/portraits/women/59.jpg",
      email: "email@gmail.com",
      phoneNumber: "phoneNumber",
    ),
    Contact(
      id: "1",
      firstName: "bfirstName",
      lastName: "lastName",
      imageUrl: "https://randomuser.me/api/portraits/women/59.jpg",
      email: "email@gmail.com",
      phoneNumber: "phoneNumber",
    ),
    Contact(
      id: "1",
      firstName: "bfirstName",
      lastName: "lastName",
      imageUrl: "https://randomuser.me/api/portraits/women/59.jpg",
      email: "email@gmail.com",
      phoneNumber: "phoneNumber",
    ),
    Contact(
      id: "1",
      firstName: "dfirstName",
      lastName: "lastName",
      imageUrl: "https://randomuser.me/api/portraits/women/59.jpg",
      email: "email@gmail.com",
      phoneNumber: "phoneNumber",
    ),
    Contact(
      id: "1",
      firstName: "gfirstName",
      lastName: "lastName",
      imageUrl: "https://randomuser.me/api/portraits/women/59.jpg",
      email: "email@gmail.com",
      phoneNumber: "phoneNumber",
    ),
    Contact(
      id: "1",
      firstName: "yfirstName",
      lastName: "lastName",
      imageUrl: "https://randomuser.me/api/portraits/women/59.jpg",
      email: "email@gmail.com",
      phoneNumber: "phoneNumber",
    ),
  ];

  @override
  Future<void> addContact(String uid, Contact contact) async {
    try {
      _contacts.add(contact);

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
  Stream<List<Contact>> get contacts {
    try {
      _initContacts();
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

  void _initContacts() async {
    try {
      Future.delayed(Duration.zero).then(
        (_) => _streamController.add(_contacts),
      );
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
