import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/domain/repositories/user_repository.dart';
import 'package:phone_book/src/domain/types/enums/storage_bucket_type.dart';

class UploadProfileImageToStorage
    extends UseCase<String, UploadProfileImageToStorageParams> {
  final UserRepository _userRepository;

  UploadProfileImageToStorage(this._userRepository);

  @override
  Future<Stream<String>> buildUseCaseStream(
      UploadProfileImageToStorageParams? params) async {
    StreamController<String> controller = StreamController();
    try {
      String downloadUrl = await _userRepository.uploadProfileImageToStorage(
          params!.imagePath, params.imageName, params.storageType);
      controller.add(downloadUrl);
      controller.close();
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      controller.addError(error, stackTrace);
    }
    return controller.stream;
  }
}

class UploadProfileImageToStorageParams {
  final String imagePath;
  final String imageName;
  final StorageBucketType storageType;

  UploadProfileImageToStorageParams(
      this.imagePath, this.imageName, this.storageType);
}
