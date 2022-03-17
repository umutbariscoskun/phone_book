import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/domain/entities/contact.dart';
import 'package:phone_book/src/domain/repositories/contact_repository.dart';
import 'package:phone_book/src/domain/repositories/user_repository.dart';
import 'package:phone_book/src/domain/types/enums/storage_bucket_type.dart';
import 'package:phone_book/src/domain/usecases/update_contact.dart';
import 'package:phone_book/src/domain/usecases/upload_contact_image_to_storage.dart';

class EditContactPresenter extends Presenter {
  late Function updateContactInformationOnComplete;
  late Function updateContactInformationOnError;

  late Function uploadContactImageToStorageOnNext;
  late Function uploadContactImageToStorageOnError;

  final UpdateContactInformation _updateContactInformation;
  final UploadContactImageToStorage _uploadContactImageToStorage;

  EditContactPresenter(
    ContactRepository _contactRepository,
    UserRepository _userRepository,
  )   : _updateContactInformation =
            UpdateContactInformation(_contactRepository, _userRepository),
        _uploadContactImageToStorage =
            UploadContactImageToStorage(_contactRepository);

  @override
  void dispose() {
    _updateContactInformation.dispose();
    _uploadContactImageToStorage.dispose();
  }

  void updateContactInformation(Contact contact) {
    _updateContactInformation.execute(_UpdateContactInformationObserver(this),
        UpdateContactInformationParams(contact));
  }

  void uploadContactImageToStorage(
      String imagePath, String imageName, StorageBucketType storageBucketType) {
    _uploadContactImageToStorage.execute(
        _UploadContactImageToStorageObserver(this),
        UploadContactImageToStorageParams(
            imagePath, imageName, storageBucketType));
  }
}

class _UpdateContactInformationObserver extends Observer<void> {
  final EditContactPresenter _presenter;

  _UpdateContactInformationObserver(this._presenter);

  @override
  void onComplete() {
    _presenter.updateContactInformationOnComplete();
  }

  @override
  void onError(e) {
    _presenter.updateContactInformationOnError(e);
  }

  @override
  void onNext(_) {}
}

class _UploadContactImageToStorageObserver extends Observer<String> {
  final EditContactPresenter _presenter;

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
