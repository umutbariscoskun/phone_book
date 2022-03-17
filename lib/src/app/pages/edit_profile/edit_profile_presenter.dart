import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/domain/entities/user.dart';
import 'package:phone_book/src/domain/repositories/user_repository.dart';
import 'package:phone_book/src/domain/types/enums/storage_bucket_type.dart';
import 'package:phone_book/src/domain/usecases/update_user_information.dart';
import 'package:phone_book/src/domain/usecases/upload_profile_image_to_storage.dart';

class EditProfilePresenter extends Presenter {
  late Function updateUserInformatioOnComplete;
  late Function updateUserInformationOnError;

  late Function uploadProfileImageToStorageOnNext;
  late Function uploadProfileImageToStorageOnError;

  final UpdateUserInformation _updateUserInformation;
  final UploadProfileImageToStorage _uploadProfileImageToStorage;

  EditProfilePresenter(UserRepository _userRepository)
      : _updateUserInformation = UpdateUserInformation(_userRepository),
        _uploadProfileImageToStorage =
            UploadProfileImageToStorage(_userRepository);
  @override
  void dispose() {
    _updateUserInformation.dispose();
    _uploadProfileImageToStorage.dispose();
  }

  void updateUserInformation(User user) {
    _updateUserInformation.execute(_UpdateUserInformationObserver(this),
        UpdateUserInformationParams(user));
  }

  void uploadProfileImageToStorage(
      String imagePath, String imageName, StorageBucketType storageBucketType) {
    _uploadProfileImageToStorage.execute(
        _UploadProfileImageToStorageObserver(this),
        UploadProfileImageToStorageParams(
            imagePath, imageName, storageBucketType));
  }
}

class _UpdateUserInformationObserver extends Observer<void> {
  final EditProfilePresenter _presenter;

  _UpdateUserInformationObserver(this._presenter);

  @override
  void onComplete() {
    _presenter.updateUserInformatioOnComplete();
  }

  @override
  void onError(e) {
    _presenter.updateUserInformationOnError(e);
  }

  @override
  void onNext(_) {}
}

class _UploadProfileImageToStorageObserver extends Observer<String> {
  final EditProfilePresenter _presenter;

  _UploadProfileImageToStorageObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    _presenter.uploadProfileImageToStorageOnError(e);
  }

  @override
  void onNext(String? response) {
    _presenter.uploadProfileImageToStorageOnNext(response);
  }
}
