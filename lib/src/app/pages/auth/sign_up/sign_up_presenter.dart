import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/domain/entities/contact.dart';
import 'package:phone_book/src/domain/repositories/user_repository.dart';
import 'package:phone_book/src/domain/types/enums/storage_bucket_type.dart';
import 'package:phone_book/src/domain/usecases/create_user.dart';
import 'package:phone_book/src/domain/usecases/sign_in.dart';
import 'package:phone_book/src/domain/usecases/upload_profile_image_to_storage.dart';

class SignUpPresenter extends Presenter {
  late Function createUserOnComplete;
  late Function createUserOnError;

  late Function signInOnComplete;
  late Function signInOnError;

  final CreateUser _createUser;
  final SignIn _signIn;

  SignUpPresenter(UserRepository _userRepository)
      : _createUser = CreateUser(_userRepository),
        _signIn = SignIn(_userRepository);

  @override
  void dispose() {
    _createUser.dispose();
    _signIn.dispose();
  }

  void createUser(String firstname, String lastName, String email,
      String phoneNumber, String imageUrl, String password) {
    _createUser.execute(
        _CreateUserObserver(this),
        CreateUserParams(
            firstname, lastName, email, phoneNumber, imageUrl, password));
  }

  void signIn(String email, String password) {
    _signIn.execute(_SignInObserver(this), SignInParams(email, password));
  }
}

class _CreateUserObserver extends Observer<void> {
  final SignUpPresenter _presenter;

  _CreateUserObserver(this._presenter);
  @override
  void onComplete() {
    _presenter.createUserOnComplete();
  }

  @override
  void onError(e) {
    _presenter.createUserOnError(e);
  }

  @override
  void onNext(_) {}
}

class _SignInObserver extends Observer<void> {
  final SignUpPresenter _presenter;

  _SignInObserver(this._presenter);
  @override
  void onComplete() {
    _presenter.signInOnComplete();
  }

  @override
  void onError(e) {
    _presenter.signInOnError(e);
  }

  @override
  void onNext(_) {}
}
