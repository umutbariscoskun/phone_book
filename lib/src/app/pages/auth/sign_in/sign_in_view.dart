import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/app/pages/auth/sign_in/sign_in_controller.dart';

class SignInView extends View {
  @override
  State<StatefulWidget> createState() {
    return _SignInViewState(SignInController());
  }
}

class _SignInViewState extends ViewState<SignInView, SignInController> {
  _SignInViewState(SignInController controller) : super(controller);
  @override
  Widget get view {
    return Scaffold();
  }
}
