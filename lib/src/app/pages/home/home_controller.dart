import 'package:flutter/material.dart';
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

  final TextEditingController editingController = TextEditingController();
  User? currentUser;

  List<Contact>? contacts;
  final Map<String, List<Contact>> groupedLists = {};

  @override
  void onInitState() {
    _presenter.getCurrentUser();
    _presenter.getContacts();
    super.onInitState();
  }

  @override
  void initListeners() {
    _presenter.getContactsOnNext = (List<Contact>? response) {
      if (response != null) {
        contacts = response;

        contacts!.forEach((contact) {
          if (groupedLists['${contact.firstName[0]}'] == null) {
            groupedLists['${contact.firstName[0]}'] = <Contact>[];
          }

          groupedLists['${contact.firstName[0]}']!.add(contact);
        });

        refreshUI();
      }
    };

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

  void refreshScreen() {
    refreshUI();
  }

  void onSearchValueSubmit(String value) async {
    if (value.trim().length > 1) {
      editingController.clear();
    }
    refreshUI();
  }
}
