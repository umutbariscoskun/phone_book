import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/domain/entities/contact.dart';
import 'package:phone_book/src/domain/repositories/contact_repository.dart';
import 'package:phone_book/src/domain/repositories/user_repository.dart';
import 'package:phone_book/src/domain/usecases/add_contact.dart';

class AddContactPresenter extends Presenter {
  late Function addContactOnComplete;
  late Function addContactOnError;

  final AddContact _addContact;

  AddContactPresenter(
      ContactRepository _contactRepository, UserRepository _userRepository)
      : _addContact = AddContact(_contactRepository, _userRepository);
  @override
  void dispose() {
    _addContact.dispose();
  }

  void addContact(Contact contact) {
    _addContact.execute(_AddContactObserver(this), AddContactToParams(contact));
  }
}

class _AddContactObserver extends Observer<void> {
  final AddContactPresenter _presenter;

  _AddContactObserver(this._presenter);

  @override
  void onComplete() {
    _presenter.addContactOnComplete();
  }

  @override
  void onError(e) {
    _presenter.addContactOnError(e);
  }

  @override
  void onNext(_) {}
}
