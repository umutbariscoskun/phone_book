import 'package:phone_book/src/domain/entities/contact.dart';
import 'package:phone_book/src/domain/types/enums/storage_bucket_type.dart';

abstract class ContactRepository {
  Future<void> addContactToFavorites(String uid, Contact contact);
  Future<void> removeContactFromFavorites(String uid, String contactId);
  Future<void> addContact(String uid, Contact contact);
  Future<void> removeContact(String uid, String contactId);
  Stream<List<Contact>> getContacts(String uid);
  Future<List<Contact>> searchContact(String searchValue);
  Future<void> updateContactInformation(String uid, Contact contact);
  Future<String> uploadContactImageToStorage(
      String imagePath, String imageName, StorageBucketType storageType);
  Stream<List<Contact>> getFavoritedContacts(String uid);
}
