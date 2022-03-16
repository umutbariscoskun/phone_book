import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/domain/entities/contact.dart';
import 'package:phone_book/src/domain/entities/user.dart';
import 'package:phone_book/src/domain/repositories/contact_repository.dart';
import 'package:phone_book/src/domain/repositories/user_repository.dart';
import 'package:phone_book/src/domain/usecases/get_contacts.dart';
import 'package:phone_book/src/domain/usecases/get_current_user.dart';
import 'package:phone_book/src/domain/usecases/search_contact.dart';

class HomePresenter extends Presenter {
  late Function getCurrentUserOnNext;
  late Function getCurrentUserOnError;

  late Function getContactsOnNext;
  late Function getContactsOnError;

  late Function searchContactOnNext;
  late Function searchContactOnError;

  final GetCurrentUser _getCurrentUser;
  final GetContacts _getContacts;
  final SearchContact _searchContact;

  HomePresenter(
    ContactRepository _contactRepository,
    UserRepository _userRepository,
  )   : _getContacts = GetContacts(_contactRepository, _userRepository),
        _getCurrentUser = GetCurrentUser(_userRepository),
        _searchContact = SearchContact(_contactRepository);

  @override
  void dispose() {
    _getContacts.dispose();
    _getCurrentUser.dispose();
    _searchContact.dispose();
  }

  void getCurrentUser() {
    _getCurrentUser.execute(_GetCurrentUserObserver(this));
  }

  void getContacts() {
    _getContacts.execute(_GetContactsObserver(this));
  }

  void searchContact(String searchValue) {
    _searchContact.execute(
        _SearchContactObserver(this), SearchContactParams(searchValue));
  }
}

class _GetCurrentUserObserver extends Observer<User> {
  final HomePresenter _presenter;

  _GetCurrentUserObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    _presenter.getCurrentUserOnError(e);
  }

  @override
  void onNext(User? response) {
    _presenter.getCurrentUserOnNext(response);
  }
}

class _GetContactsObserver extends Observer<List<Contact>> {
  final HomePresenter _presenter;

  _GetContactsObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    _presenter.getContactsOnError(e);
  }

  @override
  void onNext(List<Contact>? response) {
    _presenter.getContactsOnNext(response);
  }
}

class _SearchContactObserver extends Observer<List<Contact>> {
  HomePresenter _presenter;
  _SearchContactObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    _presenter.searchContactOnError(e);
  }

  @override
  void onNext(List<Contact>? response) {
    _presenter.searchContactOnNext(response);
  }
}
