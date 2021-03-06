import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/domain/entities/contact.dart';
import 'package:phone_book/src/domain/repositories/user_repository.dart';

class CreateUser extends UseCase<void, CreateUserParams> {
  final UserRepository _userRepository;

  CreateUser(this._userRepository);
  @override
  Future<Stream<void>> buildUseCaseStream(CreateUserParams? params) async {
    StreamController<void> controller = StreamController();
    try {
      await _userRepository.createUser(
        params!.firstname,
        params.lastname,
        params.email,
        params.phoneNumber,
        params.imageUrl,
        params.password,
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

class CreateUserParams {
  final String firstname;
  final String lastname;
  final String email;
  final String phoneNumber;
  final String imageUrl;
  final String password;

  CreateUserParams(
    this.firstname,
    this.lastname,
    this.email,
    this.phoneNumber,
    this.imageUrl,
    this.password,
  );
}
