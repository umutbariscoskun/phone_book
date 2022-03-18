import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/app/constants.dart';
import 'package:phone_book/src/app/pages/contact_detail/contact_detail_controller.dart';
import 'package:phone_book/src/app/pages/edit_contact/edit_contact_view.dart';
import 'package:phone_book/src/app/texts.dart';
import 'package:phone_book/src/app/widgets/default_app_bar.dart';
import 'package:phone_book/src/app/widgets/default_progress_indicator.dart';
import 'package:phone_book/src/data/repositories/data_contact_repository.dart';
import 'package:phone_book/src/data/repositories/data_user_repository.dart';
import 'package:phone_book/src/domain/entities/contact.dart';

class ContactDetailView extends View {
  final Contact contact;

  ContactDetailView(this.contact);
  @override
  State<StatefulWidget> createState() {
    return _ContactDetailViewState(
      ContactDetailController(
        DataContactRepository(),
        DataUserRepository(),
        contact,
      ),
    );
  }
}

class _ContactDetailViewState
    extends ViewState<ContactDetailView, ContactDetailController> {
  _ContactDetailViewState(ContactDetailController controller)
      : super(controller);

  @override
  Widget get view {
    Size size = MediaQuery.of(context).size;
    EdgeInsets padding = MediaQuery.of(context).padding;
    return Scaffold(
      backgroundColor: kBackGroundColor,
      key: globalKey,
      body: Container(
        child: Column(
          children: [
            DefaultAppBar(null),
            Expanded(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                child: widget.contact != null
                    ? Column(
                        children: [
                          _ContactProfileContainer(widget.contact),
                          SizedBox(height: 30),
                          _ContactDetailContainer(widget.contact)
                        ],
                      )
                    : Center(
                        child: DefaultProgressIndicator(),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactProfileContainer extends StatelessWidget {
  final Contact contact;

  _ContactProfileContainer(this.contact);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
      width: size.width,
      child: Column(
        children: [
          SizedBox(height: 12),
          ClipOval(
            child: Image.network(
              contact.imageUrl,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: defaultSizedBoxPadding),
          Text(
            contact.firstName + " " + contact.lastName,
            style: kTitleStyle(kBlack),
          ),
          SizedBox(height: defaultSizedBoxPadding),
          ControlledWidgetBuilder<ContactDetailController>(
            builder: (context, controller) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => EditContactView(contact),
                      ),
                    ),
                    behavior: HitTestBehavior.translucent,
                    child: Icon(Icons.edit),
                  ),
                  SizedBox(width: defaultSizedBoxPadding),
                  GestureDetector(
                    onTap: () => controller.removeContact(contact.id),
                    behavior: HitTestBehavior.translucent,
                    child: Icon(Icons.delete),
                  ),
                  SizedBox(width: defaultSizedBoxPadding),
                  GestureDetector(
                    onTap: () =>
                        controller.toggleContactFavoriteSituation(contact),
                    behavior: HitTestBehavior.translucent,
                    child: !controller.isFavorited
                        ? Icon(Icons.favorite_border)
                        : Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}

class _ContactDetailContainer extends StatelessWidget {
  final Contact contact;

  _ContactDetailContainer(this.contact);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    EdgeInsets padding = MediaQuery.of(context).padding;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizantalPadding),
      width: size.width,
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: horizantalPadding),
          Text(
            PhoneBookTexts.detail,
            style: TextStyle(
              fontSize: 18,
              color: kPrimaryColor,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
          ),
          SizedBox(height: horizantalPadding),
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
                        contact.phoneNumber,
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
                        contact.phoneNumber,
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
                        contact.email,
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
                        contact.phoneNumber,
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
                        contact.phoneNumber,
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
          )
        ],
      ),
    );
  }
}
