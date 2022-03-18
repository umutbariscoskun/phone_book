import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phone_book/src/app/constants.dart';
import 'package:phone_book/src/app/pages/edit_contact/edit_contact_presenter.dart';
import 'package:phone_book/src/app/pages/home/home_view.dart';
import 'package:phone_book/src/app/texts.dart';
import 'package:phone_book/src/app/widgets/image_source_dialog.dart';
import 'package:phone_book/src/domain/entities/contact.dart';
import 'package:phone_book/src/domain/repositories/contact_repository.dart';
import 'package:phone_book/src/domain/repositories/user_repository.dart';
import 'package:phone_book/src/domain/types/enums/banner_type.dart';
import 'package:phone_book/src/domain/types/enums/image_source_type.dart';
import 'package:phone_book/src/domain/types/enums/storage_bucket_type.dart';

class EditContactController extends Controller {
  final EditContactPresenter _presenter;
  final Contact contactFromView;

  EditContactController(
    ContactRepository _contactRepository,
    UserRepository _userRepository,
    this.contactFromView,
  ) : _presenter = EditContactPresenter(_contactRepository, _userRepository);

  final ImagePicker imagePicker = ImagePicker();
  String? downloadUrl;
  String? email;
  String? firstName;
  String? lastName;
  String? phoneNumber;

  XFile? pickedImage;

  @override
  void initListeners() {
    _presenter.updateContactInformationOnComplete = () {
      Navigator.push(
        getContext(),
        CupertinoPageRoute(
          builder: (context) => HomeView(),
        ),
      );
      kShowBanner(BannerType.SUCCESS,
          PhoneBookTexts.theContactHasBeenSuccessfullyUpdated, getContext());
    };

    _presenter.updateContactInformationOnError = () {
      kShowBanner(
          BannerType.ERROR, PhoneBookTexts.someThingWentWrong, getContext());
    };

    _presenter.uploadContactImageToStorageOnNext = (String? response) {
      downloadUrl = response;
      kShowBanner(
          BannerType.SUCCESS, PhoneBookTexts.updatePleaseWait, getContext());
      refreshUI();
    };

    _presenter.uploadContactImageToStorageOnError = (e) {};
  }

  void onImageGotPressed() async {
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

  void updateContactInformation() {
    Contact editedContact = Contact(
      id: contactFromView.id,
      firstName: firstName != null ? firstName! : contactFromView.firstName,
      lastName: lastName != null ? lastName! : contactFromView.lastName,
      imageUrl: downloadUrl != null ? downloadUrl! : contactFromView.imageUrl,
      email: email != null ? email! : contactFromView.email,
      phoneNumber:
          phoneNumber != null ? phoneNumber! : contactFromView.phoneNumber,
    );
    _presenter.updateContactInformation(editedContact);
    refreshUI();
  }
}
