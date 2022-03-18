import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phone_book/src/app/constants.dart';
import 'package:phone_book/src/app/pages/add_contact/add_contact_presenter.dart';
import 'package:phone_book/src/app/texts.dart';
import 'package:phone_book/src/app/widgets/image_source_dialog.dart';
import 'package:phone_book/src/domain/entities/contact.dart';
import 'package:phone_book/src/domain/repositories/contact_repository.dart';
import 'package:phone_book/src/domain/repositories/user_repository.dart';
import 'package:phone_book/src/domain/types/enums/banner_type.dart';
import 'package:phone_book/src/domain/types/enums/image_source_type.dart';
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
  bool isLoading = false;

  final ImagePicker imagePicker = ImagePicker();
  XFile? pickedImage;
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
    _presenter.addContact(
      firstName!,
      lastName!,
      downloadUrl != null ? downloadUrl! : profilePhotoPlaceHolder,
      email!,
      phoneNumber!,
    );
    refreshUI();
  }

  void onImageGotPressed() async {
    isLoading = true;
    final ImageSourceType? imageType = await showDialog(
      context: getContext(),
      builder: (context) {
        return ImageSourceDialog();
      },
    );

    if (imageType == ImageSourceType.GALLERY) {
      pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    }
    if (imageType == ImageSourceType.CAMERA) {
      print("camera1");

      pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
      print(pickedImage!.name.toString());
    }
    _presenter.uploadContactImageToStorage(
      pickedImage!.path,
      pickedImage!.name,
      StorageBucketType.PROFILE,
    );
    refreshUI();
  }
}
