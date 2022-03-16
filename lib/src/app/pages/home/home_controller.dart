import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/app/pages/home/home_presenter.dart';
import 'package:phone_book/src/domain/entities/contact.dart';
import 'package:phone_book/src/domain/repositories/contact_repository.dart';
import 'package:phone_book/src/domain/repositories/user_repository.dart';

import '../../../domain/entities/user.dart';

class HomeController extends Controller {
  final HomePresenter _presenter;

  HomeController(
      ContactRepository _contactRepository, UserRepository _userRepository)
      : _presenter = HomePresenter(_contactRepository, _userRepository);

  User? currentUser;

  @override
  void onInitState() {
    _presenter.getCurrentUser();
    super.onInitState();
  }

  @override
  void initListeners() {
    _presenter.getContactsOnNext = (List<Contact>? response) {};

    _presenter.getContactsOnError = (e) {};

    _presenter.getCurrentUserOnNext = (User? response) {
      if (response != null) {
        currentUser = response;
        refreshUI();
      }
    };

    _presenter.getCurrentUserOnError = (e) {};

    _presenter.searchContactOnNext = (List<Contact>? response) {};

    _presenter.searchContactOnError = (e) {};
  }

  @override
  void dispose() {
    _presenter.dispose();
    super.dispose();
  }
}
