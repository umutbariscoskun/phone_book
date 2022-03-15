import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'firstName': firstname,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phoneNumber,
        'imageUrl': imageUrl,
      });
      currentUser = userCredential.user as ent.User;
    } catch (e, st) {
      print(e);
      print(st);
    }
  }

  @override
  Future<ent.User> getCurrentUser() async {
    String uid = _auth.currentUser!.uid;
    print('Authenticated Uid: ' + uid);

    _documentSnapshot = await _firestore.collection('Person').doc(uid).get();

    currentUser = ent.User.fromJson(_documentSnapshot);

    return currentUser;
  }

  @override
  Future<void> signIn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  Future<String> uploadProfileImageToStorage(
      String imagePath, String imageName, StorageBucketType storageType) async {
    String url = await UploadHelper()
        .uploadImageToStorage(imagePath, imageName, storageType);
    return url;
  }
}
