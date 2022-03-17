import 'package:cross_file/cross_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phone_book/src/app/constants.dart';
import 'package:phone_book/src/app/pages/edit_profile/edit_profile_presenter.dart';
import 'package:phone_book/src/app/pages/home/home_view.dart';
import 'package:phone_book/src/app/texts.dart';
import 'package:phone_book/src/domain/entities/user.dart';
import 'package:phone_book/src/domain/repositories/user_repository.dart';
import 'package:phone_book/src/domain/types/enums/banner_type.dart';
import 'package:phone_book/src/domain/types/enums/storage_bucket_type.dart';

class EditProfileController extends Controller {
  final EditProfilePresenter _presenter;
  final User currentUser;

  EditProfileController(
    UserRepository _userRepository,
    this.currentUser,
  ) : _presenter = EditProfilePresenter(_userRepository);

  String? downloadUrl;
  String? firstName;
  String? lastName;
  String? phoneNumber;

  final ImagePicker imagePicker = ImagePicker();

  @override
  void initListeners() {
    _presenter.updateUserInformatioOnComplete = () {
      Navigator.push(
        getContext(),
        CupertinoPageRoute(
          builder: (context) => HomeView(),
        ),
      );
      kShowBanner(BannerType.SUCCESS, PhoneBookTexts.updateProfileInformation,
          getContext());
    };

    _presenter.updateUserInformationOnError = (e) {
      kShowBanner(
          BannerType.ERROR, PhoneBookTexts.someThingWentWrong, getContext());
    };

    _presenter.uploadProfileImageToStorageOnNext = (String? response) {
      downloadUrl = response;
      refreshUI();
    };

    _presenter.uploadProfileImageToStorageOnError = (e) {};
  }

  @override
  void dispose() {
    _presenter.dispose();
    super.dispose();
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

  void pickImage() async {
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.gallery);

    _presenter.uploadProfileImageToStorage(
      image!.path,
      image.name,
      StorageBucketType.PROFILE,
    );
    refreshUI();
  }

  void updateProfileInformation() {
    User editedUser = User(
      currentUser.uid,
      firstName != null ? firstName! : currentUser.firstName,
      lastName != null ? lastName! : currentUser.lastName,
      currentUser.email,
      phoneNumber != null ? phoneNumber! : currentUser.phoneNumber,
      downloadUrl != null ? downloadUrl! : currentUser.imageUrl,
    );
    _presenter.updateUserInformation(editedUser);
    refreshUI();
  }
}
