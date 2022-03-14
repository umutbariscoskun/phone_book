import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/app/pages/favorites/favorites_controller.dart';

class FavoritesView extends View {
  @override
  State<StatefulWidget> createState() {
    return _FavoritesViewState(FavoritesController());
  }
}

class _FavoritesViewState
    extends ViewState<FavoritesView, FavoritesController> {
  _FavoritesViewState(FavoritesController controller) : super(controller);
  Widget get view {
    return Scaffold(key: globalKey);
  }
}
