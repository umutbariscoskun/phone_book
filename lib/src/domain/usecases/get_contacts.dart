import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/domain/entities/contact.dart';
import 'package:phone_book/src/domain/entities/user.dart';
import 'package:phone_book/src/domain/repositories/contact_repository.dart';
import 'package:phone_book/src/domain/repositories/user_repository.dart';

class GetContacts extends UseCase<List<Contact>, void> {
  final ContactRepository _contactRepository;
  final UserRepository _userRepository;
  final StreamController<List<Contact>> _controller;

  GetContacts(
    this._contactRepository,
    this._userRepository,
  ) : _controller = StreamController.broadcast();

  @override
  Future<Stream<List<Contact>?>> buildUseCaseStream(void params) async {
    try {
      User user = await _userRepository.getCurrentUser();
      String uid = user.uid;
      _contactRepository.getContacts(uid).listen((List<Contact> contacts) {
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
