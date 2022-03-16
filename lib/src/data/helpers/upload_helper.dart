import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:phone_book/src/domain/types/enums/storage_bucket_type.dart';

class UploadHelper {
  Future<String> uploadImageToStorage(
      String imagePath, String imageName, StorageBucketType storageType) async {
    final FirebaseStorage _firebaseStorage = FirebaseStorage.instanceFor(
      bucket: storageType == StorageBucketType.CONTACTS
          ? "contacts/"
          : "profile_images/",
    );

    String filePath = '$imageName-${DateTime.now().millisecondsSinceEpoch}.png';

    String fullPath = storageType == StorageBucketType.CONTACTS
        ? 'contatcs/$filePath'
        : 'profile_images/$filePath';

    Reference fileReference = _firebaseStorage.ref().child(fullPath);

    UploadTask uploadTask = fileReference.putFile(File(imagePath));

    String? imageUrl;
    await uploadTask.whenComplete(() async {
      try {
        imageUrl = await fileReference.getDownloadURL();
      } catch (e, st) {
        print(e);
        print(st);
        rethrow;
      }
    });

    return imageUrl!;
  }
}
