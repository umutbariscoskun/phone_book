import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:phone_book/src/app/constants.dart';
import 'package:phone_book/src/app/pages/contact_detail/contact_detail_view.dart';
import 'package:phone_book/src/app/pages/edit_profile/edit_profile_view.dart';
import 'package:phone_book/src/app/pages/profile/profile_controller.dart';
import 'package:phone_book/src/app/texts.dart';
import 'package:phone_book/src/app/widgets/default_app_bar.dart';
import 'package:phone_book/src/data/repositories/data_contact_repository.dart';
import 'package:phone_book/src/data/repositories/data_user_repository.dart';
import 'package:phone_book/src/domain/entities/contact.dart';
import 'package:phone_book/src/domain/entities/user.dart';

class ProfileView extends View {
  final User currentUser;

  List<Contact> favoritedContacts;

  ProfileView(
    this.currentUser,
    this.favoritedContacts,
  );
  @override
  State<StatefulWidget> createState() {
    return _ProfileViewState(
        ProfileController(DataUserRepository(), DataContactRepository()));
  }
}

class _ProfileViewState extends ViewState<ProfileView, ProfileController> {
  _ProfileViewState(ProfileController controller) : super(controller);
  @override
  Widget get view {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kWhite,
      key: globalKey,
      body: Column(
        children: [
          DefaultAppBar(PhoneBookTexts.myProfile),
          Expanded(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              child: Column(
                children: [
                  _ProfileDetailContainer(widget.currentUser),
                  SizedBox(
                    height: defaultSizedBoxPadding,
                  ),
                  ControlledWidgetBuilder<ProfileController>(
                      builder: (context, controller) {
                    return widget.favoritedContacts.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: horizantalPadding),
                                child: Text(PhoneBookTexts.myFavorites,
                                    style: kTitleStyle(kBlack)),
                              ),
                              SizedBox(height: defaultSizedBoxPadding),
                              _FavoritesContainer(widget.favoritedContacts),
                            ],
                          )
                        : Column(
                            children: [
                              Opacity(
                                opacity: 0.5,
                                child: Container(
                                  width: size.width,
                                  height: 100,
                                  child: SvgPicture.asset(
                                      "assets/images/favorite_empty.svg"),
                                ),
                              ),
                              SizedBox(height: defaultSizedBoxPadding),
                              Container(
                                child: Text(
                                  PhoneBookTexts.youDontHaveFavorite,
                                  style: kContentStyleThin(
                                      kBlack.withOpacity(0.5)),
                                ),
                              ),
                            ],
                          );
                  })
                ],
              ),
            ),
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
          SizedBox(height: defaultSizedBoxPadding),
        ],
      ),
    );
  }
}

class _FavoritesContainer extends StatelessWidget {
  final List<Contact> favorites;

  _FavoritesContainer(this.favorites);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: horizantalPadding),
        width: size.width,
        child: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int i = 0; i < favorites.length; i++)
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => ContactDetailView(
                              favorites[i],
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    height: 90,
                                    width: 90,
                                    child: Image(
                                      image:
                                          NetworkImage(favorites[i].imageUrl),
                                      fit: BoxFit.fill,
                                    )),
                                SizedBox(width: defaultSizedBoxPadding),
                              ],
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: 90,
                              child: Text(
                                favorites[i].firstName +
                                    " " +
                                    favorites[i].lastName,
                                style: kContentStyleBold(kBlack),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            )
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
