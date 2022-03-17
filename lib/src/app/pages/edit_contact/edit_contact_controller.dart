import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phone_book/src/app/constants.dart';
import 'package:phone_book/src/app/pages/edit_contact/edit_contact_presenter.dart';
import 'package:phone_book/src/app/pages/home/home_view.dart';
import 'package:phone_book/src/app/texts.dart';
import 'package:phone_book/src/domain/entities/contact.dart';
import 'package:phone_book/src/domain/repositories/contact_repository.dart';
import 'package:phone_book/src/domain/repositories/user_repository.dart';
import 'package:phone_book/src/domain/types/enums/banner_type.dart';
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
      refreshUI();
    };

    _presenter.uploadContactImageToStorageOnError = (e) {};
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
      imageUrl: downloadUrl != null ? downloadUrl! : profilePhotoPlaceHolder,
      email: email != null ? email! : contactFromView.email,
      phoneNumber:
          phoneNumber != null ? phoneNumber! : contactFromView.phoneNumber,
    );
    _presenter.updateContactInformation(editedContact);
    refreshUI();
  }
}
