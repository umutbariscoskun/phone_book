import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/app/pages/contact_detail/contact_detail_controller.dart';

class ContactDetailView extends View {
  @override
  State<StatefulWidget> createState() {
    return _ContactDetailViewState(ContactDetailController());
  }
}

class _ContactDetailViewState
    extends ViewState<ContactDetailView, ContactDetailController> {
  _ContactDetailViewState(ContactDetailController controller)
      : super(controller);

  @override
  Widget get view {
    return Scaffold(
      key: globalKey,
    );
  }
}
