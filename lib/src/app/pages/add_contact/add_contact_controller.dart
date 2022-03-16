import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/app/pages/add_contact/add_contact_presenter.dart';
import 'package:phone_book/src/domain/repositories/contact_repository.dart';
import 'package:phone_book/src/domain/repositories/user_repository.dart';

class AddContactController extends Controller {
  final AddContactPresenter _presenter;

  AddContactController(
    ContactRepository _contactRepository,
    UserRepository _userRepository,
  ) : _presenter = AddContactPresenter(_contactRepository, _userRepository);

  String? email;
  String? password;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  @override
  void initListeners() {
    // TODO: implement initListeners
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
}
