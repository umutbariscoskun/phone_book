import 'dart:math';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/domain/entities/contact.dart';
import 'package:phone_book/src/domain/repositories/contact_repository.dart';
import 'package:phone_book/src/domain/repositories/user_repository.dart';
import 'package:phone_book/src/domain/types/enums/storage_bucket_type.dart';
import 'package:phone_book/src/domain/usecases/add_contact.dart';
import 'package:phone_book/src/domain/usecases/upload_contact_image_to_storage.dart';
import 'package:phone_book/src/domain/usecases/upload_profile_image_to_storage.dart';

class AddContactPresenter extends Presenter {
  late Function addContactOnComplete;
  late Function addContactOnError;

  late Function uploadContactImageToStorageOnNext;
  late Function uploadContactImageToStorageOnError;

  final AddContact _addContact;
  final UploadContactImageToStorage _uploadContactImageToStorage;

  AddContactPresenter(
      ContactRepository _contactRepository, UserRepository _userRepository)
      : _addContact = AddContact(_contactRepository, _userRepository),
        _uploadContactImageToStorage =
            UploadContactImageToStorage(_contactRepository);
  @override
  void dispose() {
    _addContact.dispose();
    _uploadContactImageToStorage.dispose();
  }

  void addContact(String firstName, String lastName, String downloadUrl,
      String email, String phoneNumber) {
    _addContact.execute(
        _AddContactObserver(this),
        AddContactToParams(
          firstName,
          lastName,
          downloadUrl,
          email,
          phoneNumber,
        ));
  }

  void uploadContactImageToStorage(
      String imagePath, String imageName, StorageBucketType storageBucketType) {
    _uploadContactImageToStorage.execute(
        _UploadContactImageToStorageObserver(this),
        UploadContactImageToStorageParams(
            imagePath, imageName, storageBucketType));
  }
}

class _AddContactObserver extends Observer<void> {
  final AddContactPresenter _presenter;

  _AddContactObserver(this._presenter);

  @override
  void onComplete() {
    _presenter.addContactOnComplete();
  }

  @override
  void onError(e) {
    _presenter.addContactOnError(e);
  }

  @override
  void onNext(_) {}
}

class _UploadContactImageToStorageObserver extends Observer<String> {
  final AddContactPresenter _presenter;

  _UploadContactImageToStorageObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    _presenter.uploadContactImageToStorageOnError(e);
  }

  @override
  void onNext(String? response) {
    _presenter.uploadContactImageToStorageOnNext(response);
  }
}
