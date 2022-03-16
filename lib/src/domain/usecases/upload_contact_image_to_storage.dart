import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/domain/repositories/contact_repository.dart';
import 'package:phone_book/src/domain/types/enums/storage_bucket_type.dart';

class UploadContactImageToStorage
    extends UseCase<String, UploadContactImageToStorageParams> {
  final ContactRepository _contactRepository;

  UploadContactImageToStorage(this._contactRepository);

  @override
  Future<Stream<String>> buildUseCaseStream(
      UploadContactImageToStorageParams? params) async {
    StreamController<String> controller = StreamController();
    try {
      String downloadUrl = await _contactRepository.uploadContactImageToStorage(
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

class UploadContactImageToStorageParams {
  final String imagePath;
  final String imageName;
  final StorageBucketType storageType;

  UploadContactImageToStorageParams(
      this.imagePath, this.imageName, this.storageType);
}
