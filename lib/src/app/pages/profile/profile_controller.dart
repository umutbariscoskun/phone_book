import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/app/constants.dart';
import 'package:phone_book/src/app/pages/profile/profile_presenter.dart';
import 'package:phone_book/src/app/pages/splash/splash_view.dart';
import 'package:phone_book/src/app/texts.dart';
import 'package:phone_book/src/domain/repositories/user_repository.dart';
import 'package:phone_book/src/domain/types/enums/banner_type.dart';

class ProfileController extends Controller {
  final ProfilePresenter _presenter;

  ProfileController(UserRepository _userRepository)
      : _presenter = ProfilePresenter(_userRepository);
  @override
  void initListeners() {
    _presenter.signOutOnComplete = () {
      Navigator.push(
        getContext(),
        CupertinoPageRoute(
          builder: (context) => SplashView(),
        ),
      );
      kShowBanner(BannerType.SUCCESS, PhoneBookTexts.signedOutSuccessfully,
          getContext());
    };

    _presenter.signOutOnError = (e) {
      kShowBanner(
          BannerType.ERROR, PhoneBookTexts.someThingWentWrong, getContext());
    };
  }

  void signOut() {
    _presenter.signOut();
    refreshUI();
  }

  @override
  void dispose() {
    _presenter.dispose();
    super.dispose();
  }
}
