import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/app/constants.dart';
import 'package:phone_book/src/app/pages/edit_contact/edit_contact_controller.dart';
import 'package:phone_book/src/app/texts.dart';
import 'package:phone_book/src/app/widgets/default_app_bar.dart';
import 'package:phone_book/src/app/widgets/default_button.dart';
import 'package:phone_book/src/data/repositories/data_contact_repository.dart';
import 'package:phone_book/src/data/repositories/data_user_repository.dart';
import 'package:phone_book/src/domain/entities/contact.dart';

class EditContactView extends View {
  final Contact contact;

  EditContactView(this.contact);
  @override
  State<StatefulWidget> createState() {
    return _EditContactViewState(EditContactController(
      DataContactRepository(),
      DataUserRepository(),
      contact,
    ));
  }
}

class _EditContactViewState
    extends ViewState<EditContactView, EditContactController> {
  _EditContactViewState(EditContactController controller) : super(controller);

  @override
  Widget get view {
    Size size = MediaQuery.of(context).size;
    EdgeInsets padding = MediaQuery.of(context).padding;
    return Scaffold(
      key: globalKey,
      backgroundColor: kWhite,
      body: Column(
        children: [
          DefaultAppBar(null),
          Expanded(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              child: ControlledWidgetBuilder<EditContactController>(
                builder: (context, controller) {
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(height: padding.top + defaultSizedBoxPadding),
                        GestureDetector(
                          onTap: () {
                            controller.onImageGotPressed();
                          },
                          child: controller.downloadUrl != null
                              ? ClipOval(
                                  child: Image.network(
                                    controller.downloadUrl!,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : ClipOval(
                                  child: Image.network(
                                    widget.contact.imageUrl,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        SizedBox(height: defaultSizedBoxPadding),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(PhoneBookTexts.editContact,
                                style: kLargeTitleStyle(kBlack)),
                            Text(PhoneBookTexts.tapToForContactImage,
                                style:
                                    kContentStyleThin(kBlack.withOpacity(0.5))),
                            SizedBox(height: defaultSizedBoxPadding),
                            Container(
                              padding: EdgeInsets.only(left: 15),
                              width: size.width - 44,
                              height: 56,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: kBlack.withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextFormField(
                                onChanged: (value) =>
                                    controller.onFirstNameTextChanged(value),
                                cursorColor: kPrimaryColor,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: widget.contact.firstName,
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              padding: EdgeInsets.only(left: 15),
                              width: size.width - 44,
                              height: 56,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: kBlack.withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextFormField(
                                onChanged: (value) =>
                                    controller.onLastNameChanged(value),
                                cursorColor: kPrimaryColor,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: widget.contact.lastName,
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              padding: EdgeInsets.only(left: 15),
                              width: size.width - 44,
                              height: 56,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: kBlack.withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextFormField(
                                onChanged: (value) =>
                                    controller.onEmailTextChanged(value),
                                cursorColor: kPrimaryColor,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: widget.contact.email,
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              padding: EdgeInsets.only(left: 15),
                              width: size.width - 44,
                              height: 56,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: kBlack.withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextFormField(
                                onChanged: (value) => controller
                                    .onPhoneNumberTextFieldChanged(value),
                                cursorColor: kPrimaryColor,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: widget.contact.phoneNumber,
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                        SizedBox(height: defaultSizedBoxPadding),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 100),
                          child: DefaultButton(
                            onPressed: () {
                              controller.updateContactInformation();
                            },
                            text: PhoneBookTexts.update,
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
