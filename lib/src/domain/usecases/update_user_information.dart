import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/domain/entities/user.dart';
import 'package:phone_book/src/domain/repositories/user_repository.dart';

class UpdateUserInformation extends UseCase<void, UpdateUserInformationParams> {
  final UserRepository _userRepository;

  UpdateUserInformation(this._userRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(
      UpdateUserInformationParams? params) async {
    StreamController<void> controller = StreamController();
    try {
      User currentUser = await _userRepository.getCurrentUser();
      String uid = currentUser.uid;
      await _userRepository.updateUserInformation(
        uid,
        params!.user,
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

class UpdateUserInformationParams {
  final User user;

  UpdateUserInformationParams(
    this.user,
  );
}
