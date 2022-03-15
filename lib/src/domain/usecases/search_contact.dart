import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/domain/entities/contact.dart';
import 'package:phone_book/src/domain/repositories/contact_repository.dart';

class SearchContact extends UseCase<List<Contact>, SearchContactParams> {
  final ContactRepository _contactRepository;

  SearchContact(this._contactRepository);

  @override
  Future<Stream<List<Contact>>> buildUseCaseStream(
      SearchContactParams? params) async {
    StreamController<List<Contact>> controller = StreamController();
    try {
      List<Contact> contacts = await _contactRepository.searchContact(
        params!.searchValue,
      );
      controller.add(contacts);
      controller.close();
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      controller.addError(error, stackTrace);
    }
    return controller.stream;
  }
}

class SearchContactParams {
  final String searchValue;

  SearchContactParams(this.searchValue);
}
