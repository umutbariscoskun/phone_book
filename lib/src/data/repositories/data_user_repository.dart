import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:phone_book/src/data/helpers/upload_helper.dart';
import 'package:phone_book/src/domain/entities/user.dart' as ent;
import 'package:phone_book/src/domain/repositories/user_repository.dart';
import 'package:phone_book/src/domain/types/enums/storage_bucket_type.dart';

class DataUserRepository implements UserRepository {
  static final _instance = DataUserRepository._internal();
  DataUserRepository._internal();
  factory DataUserRepository() => _instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late ent.User currentUser;
  late DocumentSnapshot<Map<String, dynamic>> _documentSnapshot;

  @override
  Future<void> createUser(
    String firstname,
    String lastName,
    String email,
    String phoneNumber,
    String imageUrl,
    String password,
  ) async {
    try {
      print(email);
      print(password);
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      _firestore.collection("Users").doc(userCredential.user!.uid).set(
        {
          'firstName': firstname,
          'lastName': lastName,
          'email': email,
          'phoneNumber': phoneNumber,
          'imageUrl':
              "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
        },
      );
    } catch (e, st) {
      print(e);
      print(st);
    }
  }

  @override
  Future<ent.User> getCurrentUser() async {
    try {
      String uid = _auth.currentUser!.uid;
      print('Authenticated Uid: ' + uid);

      _documentSnapshot = await _firestore.collection('Users').doc(uid).get();

      currentUser = ent.User.fromJson(_documentSnapshot);

      return currentUser;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future<String> uploadProfileImageToStorage(
      String imagePath, String imageName, StorageBucketType storageType) async {
    try {
      String url = await UploadHelper()
          .uploadImageToStorage(imagePath, imageName, storageType);
      return url;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future<void> updateUserInformation(String uid, ent.User editedUser) async {
    try {
      final CollectionReference collectionReference =
          _firestore.collection("Users");

      collectionReference.doc(uid).update({
        'firstName': editedUser.firstName,
        'lastName': editedUser.lastName,
        'imageUrl': editedUser.imageUrl,
        'email': editedUser.email,
        'phoneNumber': editedUser.phoneNumber,
      });

      currentUser.firstName = editedUser.firstName;
      currentUser.lastName = editedUser.lastName;
      currentUser.email = editedUser.email;
      currentUser.phoneNumber = editedUser.phoneNumber;
      currentUser.imageUrl = editedUser.imageUrl;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }
}
