import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/app/pages/search_result/search_result_controller.dart';
import 'package:phone_book/src/app/widgets/default_app_bar.dart';

class SearchResultView extends View {
  final String searchValue;

  SearchResultView(this.searchValue);
  @override
  State<StatefulWidget> createState() {
    return _SearchResultViewState(SearchResultController());
  }
}

class _SearchResultViewState
    extends ViewState<SearchResultView, SearchResultController> {
  _SearchResultViewState(SearchResultController controller) : super(controller);

  @override
  Widget get view {
    return Scaffold(
      key: globalKey,
      body: Column(
        children: [
          DefaultAppBar(null),
          Expanded(
              child: SingleChildScrollView(
            physics:
                AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          ))
        ],
      ),
    );
  }
}
