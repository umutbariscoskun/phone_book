import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/domain/repositories/user_repository.dart';

class SignIn extends UseCase<void, SignInParams> {
  final UserRepository _userRepository;

  SignIn(this._userRepository);
  @override
  Future<Stream<void>> buildUseCaseStream(SignInParams? params) async {
    StreamController<void> controller = StreamController();
    try {
      await _userRepository.signIn(params!.email, params.password);
      controller.close();
    } catch (e, st) {
      print(e);
      print(st);
      controller.addError(e, st);
    }
    return controller.stream;
  }
}

class SignInParams {
  final String email;
  final String password;

  SignInParams(this.email, this.password);
}
