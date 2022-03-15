import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/domain/entities/user.dart';
import 'package:phone_book/src/domain/repositories/contact_repository.dart';
import 'package:phone_book/src/domain/repositories/user_repository.dart';

class RemoveContactFromFavorites
    extends UseCase<void, RemoveContactFromFavoritesParams> {
  final ContactRepository _contactRepository;
  final UserRepository _userRepository;

  RemoveContactFromFavorites(
    this._contactRepository,
    this._userRepository,
  );

  @override
  Future<Stream<void>> buildUseCaseStream(params) async {
    StreamController<void> controller = StreamController();

    try {
      User user = await _userRepository.getCurrentUser();
      String uid = user.uid;

      await _contactRepository.removeContactFromFavorites(
          uid, params!.contactId);
      controller.close();
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
    return controller.stream;
  }
}

class RemoveContactFromFavoritesParams {
  final String contactId;

  RemoveContactFromFavoritesParams(this.contactId);
}
