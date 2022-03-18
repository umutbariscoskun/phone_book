import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phone_book/src/app/constants.dart';
import 'package:phone_book/src/app/pages/search_result/search_result_controller.dart';
import 'package:phone_book/src/app/texts.dart';
import 'package:phone_book/src/app/widgets/default_app_bar.dart';
import 'package:phone_book/src/app/widgets/default_progress_indicator.dart';
import 'package:phone_book/src/domain/entities/contact.dart';

class SearchResultView extends View {
  final List<Contact> searchedContacts;

  SearchResultView(this.searchedContacts);
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
    Size size = MediaQuery.of(context).size;
    EdgeInsets padding = MediaQuery.of(context).padding;

    return Scaffold(
      key: globalKey,
      backgroundColor: kWhite,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DefaultAppBar(null),
          Expanded(
            child: widget.searchedContacts.isNotEmpty
                ? SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    child: Column(
                      children: [
                        for (int i = 0; i < widget.searchedContacts.length; i++)
                          Text(
                            widget.searchedContacts[i].firstName,
                            style: kContentStyleBold(kBlack),
                          )
                      ],
                    ))
                : Center(
                    child: Opacity(
                      opacity: 0.5,
                      child: Column(
                        children: [
                          Container(
                            width: size.width - 100,
                            height: size.width - 50,
                            child: SvgPicture.asset(
                              "assets/images/not_found.svg",
                            ),
                          ),
                          Container(
                            width: size.width - 50,
                            child: Text(PhoneBookTexts.notFound,
                                style:
                                    kContentStyleThin(kBlack.withOpacity(0.5))),
                          )
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
