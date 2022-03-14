import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/app/pages/profile/profile_controller.dart';

class ProfileView extends View {
  @override
  State<StatefulWidget> createState() {
    return _ProfileViewState(ProfileController());
  }
}

class _ProfileViewState extends ViewState<ProfileView, ProfileController> {
  _ProfileViewState(ProfileController controller) : super(controller);
  @override
  Widget get view {
    return Scaffold();
  }
}
