import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/domain/entities/contact.dart';
import 'package:phone_book/src/domain/repositories/contact_repository.dart';
import 'package:phone_book/src/domain/repositories/user_repository.dart';
import 'package:phone_book/src/domain/usecases/add_contact_to_favorites.dart';
import 'package:phone_book/src/domain/usecases/remove_contact.dart';
import 'package:phone_book/src/domain/usecases/remove_contact_from_favorites.dart';

class ContactDetailPresenter extends Presenter {
  late Function removeContactOnComplete;
  late Function removeContactOnError;

  late Function addContactToFavoritesOnComplete;
  late Function addContactToFavoritesOnError;

  late Function removeContactsFromFavoritesOnComplete;
  late Function removeContactsFromFavoritesOnError;

  final RemoveContact _removeContact;
  final AddContactToFavorites _addContactToFavorites;
  final RemoveContactFromFavorites _removeContactFromFavorites;

  ContactDetailPresenter(
      ContactRepository _contactRepository, UserRepository _userRepository)
      : _removeContact = RemoveContact(_contactRepository, _userRepository),
        _addContactToFavorites =
            AddContactToFavorites(_contactRepository, _userRepository),
        _removeContactFromFavorites =
            RemoveContactFromFavorites(_contactRepository, _userRepository);
  @override
  void dispose() {
    _removeContact.dispose();
    _addContactToFavorites.dispose();
    _removeContactFromFavorites.dispose();
  }

  void removeContact(String contactId) {
    _removeContact.execute(
        _RemoveContactObserver(this), RemoveContactParams(contactId));
  }

  void addContactToFavorites(Contact contact) {
    _addContactToFavorites.execute(_AddContactToFavoritesObserver(this),
        AddContactToFavoritesParams(contact));
  }

  void removeContactFromFavorites(String contactId) {
    _removeContactFromFavorites.execute(
        _RemoveContactFromFavoritesObserver(this),
        RemoveContactFromFavoritesParams(contactId));
  }
}

class _RemoveContactObserver extends Observer<void> {
  final ContactDetailPresenter _presenter;

  _RemoveContactObserver(this._presenter);
  @override
  void onComplete() {
    _presenter.removeContactOnComplete();
  }

  @override
  void onError(e) {
    _presenter.removeContactOnError(e);
  }

  @override
  void onNext(_) {}
}

class _AddContactToFavoritesObserver extends Observer<void> {
  final ContactDetailPresenter _presenter;

  _AddContactToFavoritesObserver(this._presenter);
  @override
  void onComplete() {
    _presenter.addContactToFavoritesOnComplete();
  }

  @override
  void onError(e) {
    _presenter.addContactToFavoritesOnError(e);
  }

  @override
  void onNext(_) {}
}

class _RemoveContactFromFavoritesObserver extends Observer<void> {
  final ContactDetailPresenter _presenter;

  _RemoveContactFromFavoritesObserver(this._presenter);

  @override
  void onComplete() {
    _presenter.removeContactsFromFavoritesOnComplete();
  }

  @override
  void onError(e) {
    _presenter.removeContactsFromFavoritesOnError(e);
  }

  @override
  void onNext(_) {}
}
