import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phone_book/src/app/constants.dart';
import 'package:phone_book/src/app/pages/add_contact/add_contact_presenter.dart';
import 'package:phone_book/src/app/texts.dart';
import 'package:phone_book/src/domain/entities/contact.dart';
import 'package:phone_book/src/domain/repositories/contact_repository.dart';
import 'package:phone_book/src/domain/repositories/user_repository.dart';
import 'package:phone_book/src/domain/types/enums/banner_type.dart';
import 'package:phone_book/src/domain/types/enums/storage_bucket_type.dart';

class AddContactController extends Controller {
  final AddContactPresenter _presenter;

  AddContactController(
    ContactRepository _contactRepository,
    UserRepository _userRepository,
  ) : _presenter = AddContactPresenter(_contactRepository, _userRepository);

  String? email;
  String? firstName;
  String? lastName;
  String? phoneNumber;

  String? downloadUrl;

  final ImagePicker imagePicker = ImagePicker();
  @override
  void initListeners() {
    _presenter.addContactOnComplete = () {
      Navigator.pop(getContext());
      kShowBanner(BannerType.SUCCESS,
          PhoneBookTexts.theContactHasBeenSuccessfullyAdded, getContext());
      refreshUI();
    };

    _presenter.addContactOnError = (e) {
      kShowBanner(
          BannerType.ERROR, PhoneBookTexts.someThingWentWrong, getContext());
    };

    _presenter.uploadContactImageToStorageOnNext = (String? response) {
      if (response != null) {
        downloadUrl = response;
        refreshUI();
      }
    };

    _presenter.uploadContactImageToStorageOnError = (e) {
      kShowBanner(
          BannerType.ERROR, PhoneBookTexts.someThingWentWrong, getContext());
    };
  }

  void onEmailTextChanged(String value) {
    email = value.trim();
    refreshUI();
  }

  void onFirstNameTextChanged(String value) {
    firstName = value;
    refreshUI();
  }

  void onLastNameChanged(String value) {
    lastName = value;
    refreshUI();
  }

  void onPhoneNumberTextFieldChanged(String value) {
    phoneNumber = value.trim().toString();
    refreshUI();
  }

  void addContact() {
    Contact contact = Contact(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      firstName: firstName!,
      lastName: lastName!,
      imageUrl: downloadUrl != null ? downloadUrl! : profilePhotoPlaceHolder,
      email: email!,
      phoneNumber: phoneNumber!,
    );
    _presenter.addContact(contact);
  }

  void pickImage() async {
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.gallery);

    _presenter.uploadContactImageToStorage(
      image!.path,
      image.name,
      StorageBucketType.CONTACTS,
    );
    refreshUI();
  }
}
