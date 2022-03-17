import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/app/constants.dart';
import 'package:phone_book/src/app/pages/contact_detail/contact_detail_presenter.dart';
import 'package:phone_book/src/app/pages/home/home_presenter.dart';
import 'package:phone_book/src/app/texts.dart';
import 'package:phone_book/src/domain/repositories/contact_repository.dart';
import 'package:phone_book/src/domain/types/enums/banner_type.dart';

class ContactDetailController extends Controller {
  final ContactDetailPresenter _presenter;

  ContactDetailController(ContactRepository _contactRepository, _userRepository)
      : _presenter =
            ContactDetailPresenter(_contactRepository, _userRepository);
  @override
  void initListeners() {
    _presenter.removeContactOnComplete = () {
      Navigator.pop(getContext());
      kShowBanner(
        BannerType.SUCCESS,
        PhoneBookTexts.theContactHasBeenSuccessfullyRemoved,
        getContext(),
      );
    };

    _presenter.removeContactOnError = (e) {
      kShowBanner(
          BannerType.ERROR, PhoneBookTexts.someThingWentWrong, getContext());
    };
  }

  void removeContact(String contactId) {
    _presenter.removeContact(contactId);
    refreshUI();
  }

  @override
  void dispose() {
    _presenter.dispose();
    super.dispose();
  }
}
