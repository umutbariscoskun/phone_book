import 'package:phone_book/src/domain/entities/contact.dart';

abstract class ContactRepository {
  Future<void> addContactToFavorites(String uid, Contact contact);
  Future<void> removeContactFromFavorites(String uid, String contactId);
  Future<void> addContact(String uid, Contact contact);
  Future<void> removeContact(String uid, String contactId);
  Stream<List<Contact>> get contacts;
  Future<List<Contact>> searchContact(String searchValue);
  Future<void> updateContact(String uid, Contact contact);
}
