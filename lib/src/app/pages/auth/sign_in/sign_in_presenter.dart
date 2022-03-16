import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/domain/repositories/user_repository.dart';
import 'package:phone_book/src/domain/usecases/sign_in.dart';

class SignInPresenter extends Presenter {
  late Function signInOnComplete;
  late Function signInOnError;

  final SignIn _signIn;

  SignInPresenter(UserRepository _userRepository)
      : _signIn = SignIn(_userRepository);

  @override
  void dispose() {
    _signIn.dispose();
  }

  void signIn(String email, String password) {
    _signIn.execute(_SignInObserver(this), SignInParams(email, password));
  }
}

class _SignInObserver extends Observer<void> {
  final SignInPresenter _presenter;

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
