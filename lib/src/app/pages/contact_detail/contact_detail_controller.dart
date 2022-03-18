import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/app/constants.dart';
import 'package:phone_book/src/app/pages/contact_detail/contact_detail_presenter.dart';
import 'package:phone_book/src/app/texts.dart';
import 'package:phone_book/src/domain/repositories/contact_repository.dart';
import 'package:phone_book/src/domain/types/enums/banner_type.dart';

import '../../../domain/entities/contact.dart';

class ContactDetailController extends Controller {
  final ContactDetailPresenter _presenter;
  final Contact contactFromView;

  ContactDetailController(
    ContactRepository _contactRepository,
    _userRepository,
    this.contactFromView,
  ) : _presenter = ContactDetailPresenter(_contactRepository, _userRepository);

  bool isFavorited = false;

  @override
  void onInitState() {
    if (contactFromView.isFavorited)
      isFavorited = true;
    else
      isFavorited = false;
    super.onInitState();
  }

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

    _presenter.addContactToFavoritesOnComplete = () {
      kVibrateLight();
    };

    _presenter.addContactToFavoritesOnError = (e) {
      kShowBanner(
          BannerType.ERROR, PhoneBookTexts.someThingWentWrong, getContext());
      refreshUI();
    };

    _presenter.removeContactsFromFavoritesOnComplete = () {
      kVibrateLight();
    };

    _presenter.removeContactsFromFavoritesOnError = (e) {
      kShowBanner(
          BannerType.ERROR, PhoneBookTexts.someThingWentWrong, getContext());
    };
  }

  void removeContact(String contactId) {
    _presenter.removeContact(contactId);
    refreshUI();
  }

  void toggleContactFavoriteSituation(Contact contact) {
    if (contact.isFavorited) {
      isFavorited = false;
      _presenter.removeContactFromFavorites(contact.id);
      refreshUI();
    } else {
      isFavorited = true;
      _presenter.addContactToFavorites(contact);
      refreshUI();
    }
  }

  @override
  void dispose() {
    _presenter.dispose();
    super.dispose();
  }
}
