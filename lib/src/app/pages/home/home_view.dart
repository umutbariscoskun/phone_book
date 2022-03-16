import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/app/constants.dart';
import 'package:phone_book/src/app/pages/home/home_controller.dart';
import 'package:phone_book/src/app/texts.dart';
import 'package:phone_book/src/app/widgets/default_progress_indicator.dart';
import 'package:phone_book/src/data/repositories/data_contact_repository.dart';
import 'package:phone_book/src/data/repositories/data_user_repository.dart';

class HomeView extends View {
  @override
  State<StatefulWidget> createState() {
    return _HomeViewState(HomeController(
      DataContactRepository(),
      DataUserRepository(),
    ));
  }
}

class _HomeViewState extends ViewState<HomeView, HomeController> {
  _HomeViewState(HomeController controller) : super(controller);
  @override
  Widget get view {
    return Scaffold(
      key: globalKey,
      backgroundColor: kWhite,
      body: ControlledWidgetBuilder<HomeController>(
        builder: (context, controller) {
          return Column(
            children: [
              controller.currentUser != null
                  ? _CurrentUserAppBar(controller.currentUser!.imageUrl)
                  : Center(
                      child: DefaultProgressIndicator(),
                    ),
            ],
          );
        },
      ),
    );
  }
}

class _CurrentUserAppBar extends StatelessWidget {
  final String imageUrl;

  _CurrentUserAppBar(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 100,
      width: size.width,
      child: Row(
        children: [
          Icon(
            Icons.menu,
            color: kBlack,
          ),
          SizedBox(width: defaultSizedBoxPadding),
          Text(
            PhoneBookTexts.myContacts,
            style: kTitleStyle(kBlack),
          ),
          CircleAvatar(
            child: Image(
              image: NetworkImage(imageUrl),
              width: 75,
              height: 75,
            ),
          )
        ],
      ),
    );
  }
}
