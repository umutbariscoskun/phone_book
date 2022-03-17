import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/app/constants.dart';
import 'package:phone_book/src/app/pages/edit_profile/edit_profile_view.dart';
import 'package:phone_book/src/app/pages/profile/profile_controller.dart';
import 'package:phone_book/src/app/texts.dart';
import 'package:phone_book/src/data/repositories/data_user_repository.dart';
import 'package:phone_book/src/domain/entities/user.dart';

class ProfileView extends View {
  final User currentUser;

  ProfileView(this.currentUser);
  @override
  State<StatefulWidget> createState() {
    return _ProfileViewState(ProfileController(DataUserRepository()));
  }
}

class _ProfileViewState extends ViewState<ProfileView, ProfileController> {
  _ProfileViewState(ProfileController controller) : super(controller);
  @override
  Widget get view {
    return Scaffold(
      backgroundColor: kWhite,
      key: globalKey,
      body: Column(
        children: [
          SizedBox(height: defaultSizedBoxPadding),
          _ProfileAppBar(),
          Expanded(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              child: Column(
                children: [
                  _ProfileDetailContainer(widget.currentUser),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    EdgeInsets padding = MediaQuery.of(context).padding;
    return Container(
      color: kWhite,
      padding: EdgeInsets.symmetric(horizontal: horizantalPadding),
      width: size.width,
      height: padding.top + 68,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => Navigator.pop(context),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  color: kBlack,
                ),
                Text(
                  PhoneBookTexts.back,
                  style: kTitleStyle(kBlack),
                ),
              ],
            ),
          ),
          Text(
            PhoneBookTexts.myProfile,
            style: kTitleStyle(kBlack),
          ),
        ],
      ),
    );
  }
}

class _ProfileDetailContainer extends StatelessWidget {
  final User currentUser;

  _ProfileDetailContainer(this.currentUser);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    EdgeInsets padding = MediaQuery.of(context).padding;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizantalPadding),
      width: size.width,
      child: Column(
        children: [
          SizedBox(height: 12),
          ClipOval(
            child: Image.network(
              currentUser.imageUrl,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: defaultSizedBoxPadding),
          Text(
            currentUser.firstName + " " + currentUser.lastName,
            style: kTitleStyle(kBlack),
          ),
          SizedBox(height: defaultSizedBoxPadding),
          ControlledWidgetBuilder<ProfileController>(
            builder: (context, controller) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => EditProfileView(currentUser),
                      ),
                    ),
                    behavior: HitTestBehavior.translucent,
                    child: Icon(Icons.edit),
                  ),
                  SizedBox(width: defaultSizedBoxPadding),
                  GestureDetector(
                    onTap: () => controller.signOut(),
                    behavior: HitTestBehavior.translucent,
                    child: Icon(Icons.exit_to_app_outlined),
                  ),
                ],
              );
            },
          ),
          SizedBox(height: defaultSizedBoxPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.phone_outlined,
                    color: kPrimaryColor,
                  ),
                  SizedBox(width: defaultSizedBoxPadding),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        PhoneBookTexts.celular,
                        style: kContentStyleThin(
                          kBlack.withOpacity(0.5),
                        ),
                      ),
                      Text(
                        currentUser.phoneNumber,
                        style: kContentStyleBold(
                          kBlack,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: kPrimaryColor.withOpacity(0.3)),
                    child: Center(
                      child: Icon(
                        Icons.phone,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: kPrimaryColor.withOpacity(0.3)),
                    child: Center(
                      child: Icon(
                        Icons.message_rounded,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: defaultSizedBoxPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.phone_outlined,
                    color: kPrimaryColor,
                  ),
                  SizedBox(width: defaultSizedBoxPadding),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        PhoneBookTexts.home,
                        style: kContentStyleThin(
                          kBlack.withOpacity(0.5),
                        ),
                      ),
                      Text(
                        currentUser.phoneNumber,
                        style: kContentStyleBold(
                          kBlack,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: kPrimaryColor.withOpacity(0.3)),
                child: Center(
                  child: Icon(
                    Icons.phone,
                    color: kPrimaryColor,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: defaultSizedBoxPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.mail_outline,
                    color: kPrimaryColor,
                  ),
                  SizedBox(width: defaultSizedBoxPadding),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        PhoneBookTexts.email,
                        style: kContentStyleThin(
                          kBlack.withOpacity(0.5),
                        ),
                      ),
                      Text(
                        currentUser.email,
                        style: kContentStyleBold(
                          kBlack,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: kPrimaryColor.withOpacity(0.3)),
                child: Center(
                  child: Icon(
                    Icons.mail,
                    color: kPrimaryColor,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: defaultSizedBoxPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image(
                    image: AssetImage("assets/images/whatsApp.png"),
                    color: kPrimaryColor,
                  ),
                  SizedBox(width: defaultSizedBoxPadding),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        PhoneBookTexts.whatsApp,
                        style: kContentStyleThin(
                          kBlack.withOpacity(0.5),
                        ),
                      ),
                      Text(
                        currentUser.phoneNumber,
                        style: kContentStyleBold(
                          kBlack,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: kPrimaryColor.withOpacity(0.3)),
                    child: Center(
                      child: Icon(
                        Icons.phone,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: kPrimaryColor.withOpacity(0.3)),
                    child: Center(
                      child: Icon(
                        Icons.message_rounded,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: defaultSizedBoxPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image(
                    image: AssetImage("assets/images/telegram.png"),
                    color: kPrimaryColor,
                  ),
                  SizedBox(width: defaultSizedBoxPadding),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        PhoneBookTexts.telegram,
                        style: kContentStyleThin(
                          kBlack.withOpacity(0.5),
                        ),
                      ),
                      Text(
                        currentUser.phoneNumber,
                        style: kContentStyleBold(
                          kBlack,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: kPrimaryColor.withOpacity(0.3)),
                    child: Center(
                      child: Icon(
                        Icons.phone,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: kPrimaryColor.withOpacity(0.3)),
                    child: Center(
                      child: Icon(
                        Icons.message_rounded,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: padding.bottom + size.width / 4,
          ),
        ],
      ),
    );
  }
}
