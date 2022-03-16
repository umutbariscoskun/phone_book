import 'package:cross_file/cross_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phone_book/src/app/pages/auth/sign_up/sign_up_presenter.dart';
import 'package:phone_book/src/app/pages/splash/splash_view.dart';
import 'package:phone_book/src/domain/entities/contact.dart';
import 'package:phone_book/src/domain/repositories/user_repository.dart';
import 'package:phone_book/src/domain/types/enums/storage_bucket_type.dart';

class SignUpController extends Controller {
  final SignUpPresenter _presenter;

  SignUpController(UserRepository _userRepository)
      : _presenter = SignUpPresenter(_userRepository);

  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? phoneNumber;
  List<Contact> contacts = [];

  @override
  void initListeners() {
    _presenter.createUserOnComplete = () {
      _presenter.signIn(email!, password!);
      refreshUI();
    };

    _presenter.createUserOnError = (e) {};

    _presenter.signInOnComplete = () {
      Navigator.push(
        getContext(),
        CupertinoPageRoute(
          builder: (context) => SplashView(),
        ),
      );
    };

    _presenter.signInOnError = (e) {};
  }

  @override
  void dispose() {
    _presenter.dispose();
    super.dispose();
  }

  void createUser() {
    String imageUrl = "";
    _presenter.createUser(
        firstName!, lastName!, email!, phoneNumber!, imageUrl, password!);
    refreshUI();
  }

  void onEmailTextChanged(String value) {
    email = value.trim();
    refreshUI();
  }

  void onPasswordTextChanged(String value) {
    password = value;
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

  void refreshScreen() {
    refreshUI();
  }
}
