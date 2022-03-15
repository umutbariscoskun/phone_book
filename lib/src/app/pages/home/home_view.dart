import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/app/pages/home/home_controller.dart';

class HomeView extends View {
  @override
  State<StatefulWidget> createState() {
    return _HomeViewState(HomeController());
  }
}

class _HomeViewState extends ViewState<HomeView, HomeController> {
  _HomeViewState(HomeController controller) : super(controller);
  @override
  Widget get view {
    return Scaffold(
      key: globalKey,
      body: Column(),
    );
  }
}
