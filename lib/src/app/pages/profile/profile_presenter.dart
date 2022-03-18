import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/domain/repositories/contact_repository.dart';
import 'package:phone_book/src/domain/repositories/user_repository.dart';
import 'package:phone_book/src/domain/usecases/sign_out.dart';

class ProfilePresenter extends Presenter {
  late Function signOutOnComplete;
  late Function signOutOnError;

  final SignOut _signOut;

  ProfilePresenter(
      UserRepository _userRepository, ContactRepository _contactRepository)
      : _signOut = SignOut(_userRepository);
  @override
  void dispose() {
    _signOut.dispose();
  }

  void signOut() {
    _signOut.execute(_SignOutObserver(this));
  }
}

class _SignOutObserver extends Observer<void> {
  final ProfilePresenter _presenter;

  _SignOutObserver(this._presenter);

  @override
  void onComplete() {
    _presenter.signOutOnComplete();
  }

  @override
  void onError(e) {
    _presenter.signOutOnError(e);
  }

  @override
  void onNext(_) {}
}
