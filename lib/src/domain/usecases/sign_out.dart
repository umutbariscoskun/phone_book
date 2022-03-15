import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/domain/repositories/user_repository.dart';

class SignOut extends UseCase<void, void> {
  final UserRepository _userRepository;

  SignOut(this._userRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(void params) async {
    StreamController<void> controller = StreamController();
    try {
      await _userRepository.signOut();
      controller.close();
    } catch (error, stackTrace) {
      controller.addError(error, stackTrace);
    }
    return controller.stream;
  }
}
