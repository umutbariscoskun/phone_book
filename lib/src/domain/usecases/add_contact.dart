import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/domain/entities/contact.dart';
import 'package:phone_book/src/domain/entities/user.dart';
import 'package:phone_book/src/domain/repositories/contact_repository.dart';
import 'package:phone_book/src/domain/repositories/user_repository.dart';

class AddContact extends UseCase<void, AddContactToParams> {
  final ContactRepository _contactRepository;
  final UserRepository _userRepository;

  AddContact(
    this._contactRepository,
    this._userRepository,
  );

  @override
  Future<Stream<void>> buildUseCaseStream(AddContactToParams? params) async {
    StreamController<void> controller = StreamController();

    try {
      User user = await _userRepository.getCurrentUser();
      String uid = user.uid;

      await _contactRepository.addContact(
        uid,
        params!.firstName,
        params.lastName,
        params.downloadUrl,
        params.email,
        params.phoneNumber,
      );
      controller.close();
    } catch (e, st) {
      print(e);
      print(st);
      controller.addError(e, st);
    }
    return controller.stream;
  }
}

class AddContactToParams {
  final String firstName;
  final String lastName;
  final String downloadUrl;
  final String email;
  final String phoneNumber;

  AddContactToParams(
    this.firstName,
    this.lastName,
    this.downloadUrl,
    this.email,
    this.phoneNumber,
  );
}
