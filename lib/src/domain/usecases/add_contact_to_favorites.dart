import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/domain/entities/contact.dart';
import 'package:phone_book/src/domain/entities/user.dart';
import 'package:phone_book/src/domain/repositories/contact_repository.dart';
import 'package:phone_book/src/domain/repositories/user_repository.dart';

class AddContactToFavorites extends UseCase<void, AddContactToFavoritesParams> {
  final ContactRepository _contactRepository;
  final UserRepository _userRepository;

  AddContactToFavorites(
    this._contactRepository,
    this._userRepository,
  );

  @override
  Future<Stream<void>> buildUseCaseStream(
      AddContactToFavoritesParams? params) async {
    StreamController<void> controller = StreamController();

    try {
      User user = await _userRepository.getCurrentUser();
      String uid = user.uid;

      await _contactRepository.addContactToFavorites(uid, params!.contact);
      controller.close();
    } catch (e, st) {
      print(e);
      print(st);
      controller.addError(e, st);
    }
    return controller.stream;
  }
}

class AddContactToFavoritesParams {
  final Contact contact;

  AddContactToFavoritesParams(
    this.contact,
  );
}
