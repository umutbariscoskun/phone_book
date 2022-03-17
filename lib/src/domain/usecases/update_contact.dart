import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/domain/entities/contact.dart';
import 'package:phone_book/src/domain/entities/user.dart';
import 'package:phone_book/src/domain/repositories/contact_repository.dart';
import 'package:phone_book/src/domain/repositories/user_repository.dart';

class UpdateContactInformation
    extends UseCase<void, UpdateContactInformationParams> {
  final ContactRepository _contactRepository;
  final UserRepository _userRepository;

  UpdateContactInformation(this._contactRepository, this._userRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(
      UpdateContactInformationParams? params) async {
    StreamController<void> controller = StreamController();
    try {
      User currentUser = await _userRepository.getCurrentUser();
      String uid = currentUser.uid;
      await _contactRepository.updateContactInformation(
        uid,
        params!.contact,
      );
      controller.close();
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      controller.addError(error, stackTrace);
    }
    return controller.stream;
  }
}

class UpdateContactInformationParams {
  final Contact contact;

  UpdateContactInformationParams(
    this.contact,
  );
}
