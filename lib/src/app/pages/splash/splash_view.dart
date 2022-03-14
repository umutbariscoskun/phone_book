import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/app/pages/home/home_view.dart';
import 'package:phone_book/src/app/pages/splash/splash_controller.dart';

class SplashView extends View {
  @override
  State<StatefulWidget> createState() {
    return _SplashViewState(SplashController());
  }
}

class _SplashViewState extends ViewState<HomeView, SplashController> {
  _SplashViewState(SplashController controller) : super(controller);

  @override
  Widget get view {
    return Scaffold(
      key: globalKey,
    );
  }
}
