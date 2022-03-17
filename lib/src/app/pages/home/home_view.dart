import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:lottie/lottie.dart';
import 'package:phone_book/src/app/constants.dart';
import 'package:phone_book/src/app/pages/add_contact/add_contact_view.dart';
import 'package:phone_book/src/app/pages/contact_detail/contact_detail_view.dart';
import 'package:phone_book/src/app/pages/home/home_controller.dart';
import 'package:phone_book/src/app/pages/profile/profile_view.dart';
import 'package:phone_book/src/app/texts.dart';
import 'package:phone_book/src/app/widgets/default_progress_indicator.dart';
import 'package:phone_book/src/data/repositories/data_contact_repository.dart';
import 'package:phone_book/src/data/repositories/data_user_repository.dart';
import 'package:phone_book/src/domain/entities/contact.dart';
import 'package:phone_book/src/domain/entities/user.dart';

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => AddContactView(),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: kPrimaryColor,
      ),
      key: globalKey,
      backgroundColor: kWhite,
      body: ControlledWidgetBuilder<HomeController>(
        builder: (context, controller) {
          return Column(
            children: [
              controller.currentUser != null
                  ? _CurrentUserAppBar(controller.currentUser!)
                  : Container(),
              Expanded(
                child: controller.contacts != null &&
                        controller.contacts!.isNotEmpty
                    ? SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        child: Column(
                          children: [
                            _SearchBar(
                              onSubmit: controller.onSearchValueSubmit,
                              text: null,
                              editingController: controller.editingController,
                              refreshUi: controller.refreshScreen,
                            ),
                            for (var entry in controller.groupedLists.entries)
                              SizedBox(
                                width: size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 18),
                                        child: Text(
                                          entry.key.toUpperCase(),
                                          style:
                                              kContentStyleBold(kPrimaryColor),
                                        )),
                                    Container(
                                        child: Column(
                                      children: [
                                        for (var i = 0;
                                            i < entry.value.length;
                                            i++)
                                          _ContactCard(entry.value[i])
                                      ],
                                    )),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      )
                    : Center(
                        child: Lottie.asset('assets/animations/empty.json'),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CurrentUserAppBar extends StatelessWidget {
  final User currentUser;

  _CurrentUserAppBar(this.currentUser);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    EdgeInsets padding = MediaQuery.of(context).padding;
    return Container(
      margin: EdgeInsets.only(left: 18, right: 18, top: padding.top),
      height: 100,
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.menu,
                color: kBlack,
              ),
              SizedBox(width: defaultSizedBoxPadding),
              Text(
                PhoneBookTexts.myContacts,
                style: kLargeTitleStyle(kBlack),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ProfileView(currentUser),
              ),
            ),
            child: ClipOval(
              child: Image.network(
                currentUser.imageUrl,
                width: 45,
                height: 45,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatefulWidget {
  final Function(String text) onSubmit;
  final String? text;
  final TextEditingController? editingController;
  final Function() refreshUi;

  _SearchBar({
    required this.onSubmit,
    required this.text,
    required this.editingController,
    required this.refreshUi,
  });

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width - 36,
      padding: EdgeInsets.only(
        bottom: 12,
      ),
      color: kWhite,
      child: Container(
        height: 41,
        width: size.width,
        color: Color(0xFFC4C4C4).withOpacity(0.1),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 12, right: 6),
              child: Container(
                child: Icon(
                  Icons.search,
                  size: 24,
                  color: kBlack.withOpacity(0.5),
                ),
              ),
            ),
            Container(
              width: size.width - 96,
              child: TextFormField(
                onChanged: (_) {
                  widget.refreshUi();
                },
                controller: widget.editingController,
                decoration: InputDecoration(
                  hintText: PhoneBookTexts.searchContact,
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: kBlack,
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.only(bottom: 9),
                  counterText: "",
                ),
                initialValue: widget.text,
                maxLength: 30,
                cursorColor: kBlack,
                onFieldSubmitted: (text) => widget.onSubmit(text),
              ),
            ),
            widget.editingController != null &&
                    widget.editingController!.text.length > 1
                ? GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      if (widget.editingController != null)
                        widget.editingController!.clear();

                      widget.refreshUi();
                    },
                    child: Container(
                        child: Icon(
                      Icons.close,
                      color: kBlack,
                      size: 15,
                    )),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  final Contact contact;

  _ContactCard(this.contact);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 18),
          width: size.width,
          height: 75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipOval(
                    child: Image.network(
                      contact.imageUrl,
                      width: 45,
                      height: 45,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: defaultSizedBoxPadding),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${contact.firstName} ${contact.lastName}',
                          style: kContentStyleBold(kBlack)),
                      Text(
                        contact.phoneNumber,
                        style: kContentStyleThin(kBlack.withOpacity(0.5)),
                      ),
                    ],
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: kBlack,
                size: 18,
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: size.width,
          height: 75,
          child: TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateColor.resolveWith(
                (_) => kPrimaryColor.withOpacity(0.5),
              ),
            ),
            child: Container(),
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => ContactDetailView(contact),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
