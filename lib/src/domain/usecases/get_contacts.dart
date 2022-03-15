import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/domain/entities/contact.dart';
import 'package:phone_book/src/domain/repositories/contact_repository.dart';

class GetContacts extends UseCase<List<Contact>, void> {
  final ContactRepository _contactRepository;
  final StreamController<List<Contact>> _controller;

  GetContacts(this._contactRepository)
      : _controller = StreamController.broadcast();

  @override
  Future<Stream<List<Contact>?>> buildUseCaseStream(void params) async {
    try {
      _contactRepository.contacts.listen((List<Contact> contacts) {
        if (!_controller.isClosed) _controller.add(contacts);
      });
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      _controller.addError(error, stackTrace);
    }
    return _controller.stream;
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
