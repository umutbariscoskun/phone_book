import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/domain/repositories/contact_repository.dart';
import 'package:phone_book/src/domain/repositories/user_repository.dart';
import 'package:phone_book/src/domain/usecases/remove_contact.dart';

class ContactDetailPresenter extends Presenter {
  late Function removeContactOnComplete;
  late Function removeContactOnError;

  final RemoveContact _removeContact;

  ContactDetailPresenter(
      ContactRepository _contactRepository, UserRepository _userRepository)
      : _removeContact = RemoveContact(_contactRepository, _userRepository);
  @override
  void dispose() {
    _removeContact.dispose();
  }

  void removeContact(String contactId) {
    _removeContact.execute(
        _RemoveContactObserver(this), RemoveContactParams(contactId));
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
