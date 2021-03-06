import 'package:phone_book/src/domain/entities/user.dart';
import 'package:phone_book/src/domain/types/enums/storage_bucket_type.dart';

abstract class UserRepository {
  Future<User> getCurrentUser();
  Future<void> signIn(String email, String password);
  Future<void> createUser(String firstName, String lastName, String email,
      String phoneNumber, String imageUrl, String password);
  Future<void> signOut();
  Future<String> uploadProfileImageToStorage(
      String imagePath, String imageName, StorageBucketType storageType);
  Future<void> updateUserInformation(String uid, User user);
}
