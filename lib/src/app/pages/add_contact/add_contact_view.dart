import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/app/pages/add_contact/add_contact_controller.dart';

class AddContactView extends View {
  @override
  State<StatefulWidget> createState() {
    return _AddContactViewState(AddContactController());
  }
}

class _AddContactViewState
    extends ViewState<AddContactView, AddContactController> {
  _AddContactViewState(AddContactController controller) : super(controller);

  @override
  Widget get view {
    return Scaffold(
      key: globalKey,
    );
  }
}
