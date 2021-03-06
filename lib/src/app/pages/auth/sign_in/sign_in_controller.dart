import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/app/constants.dart';
import 'package:phone_book/src/app/pages/auth/sign_in/sign_in_presenter.dart';
import 'package:phone_book/src/app/pages/splash/splash_view.dart';
import 'package:phone_book/src/app/texts.dart';
import 'package:phone_book/src/domain/entities/contact.dart';
import 'package:phone_book/src/domain/repositories/user_repository.dart';
import 'package:phone_book/src/domain/types/enums/banner_type.dart';

class SignInController extends Controller {
  final SignInPresenter _presenter;

  SignInController(UserRepository _userRepository)
      : _presenter = SignInPresenter(_userRepository);

  String? password;
  String? email;

  @override
  void initListeners() {
    _presenter.signInOnComplete = () {
      Navigator.push(
        getContext(),
        CupertinoPageRoute(
          builder: (context) => SplashView(),
        ),
      );
      kShowBanner(BannerType.SUCCESS, PhoneBookTexts.signedInSuccessfully,
          getContext());
    };

    _presenter.signInOnError = (e) {
      kShowBanner(
          BannerType.ERROR, PhoneBookTexts.someThingWentWrong, getContext());
    };
  }

  void onEmailTextChanged(String value) {
    email = value.trim();
    refreshUI();
  }

  void onPasswordTextChanged(String value) {
    password = value;
    refreshUI();
  }

  void signIn() {
    _presenter.signIn(email!, password!);
    refreshUI();
  }
}
