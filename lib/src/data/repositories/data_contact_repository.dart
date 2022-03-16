import 'package:phone_book/src/domain/entities/contact.dart';
import 'package:phone_book/src/domain/repositories/contact_repository.dart';

class DataContactRepository implements ContactRepository {
  @override
  Future<void> addContact(String uid, Contact contact) {
    // TODO: implement addContact
    throw UnimplementedError();
  }

  @override
  Future<void> addContactToFavorites(String uid, Contact contact) {
    // TODO: implement addContactToFavorites
    throw UnimplementedError();
  }

  @override
  // TODO: implement contacts
  Stream<List<Contact>> get contacts => throw UnimplementedError();

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
}
