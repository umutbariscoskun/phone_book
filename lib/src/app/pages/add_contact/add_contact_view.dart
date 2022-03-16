import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/app/constants.dart';
import 'package:phone_book/src/app/pages/add_contact/add_contact_controller.dart';
import 'package:phone_book/src/app/texts.dart';
import 'package:phone_book/src/app/widgets/default_button.dart';
import 'package:phone_book/src/data/repositories/data_contact_repository.dart';
import 'package:phone_book/src/data/repositories/data_user_repository.dart';

class AddContactView extends View {
  @override
  State<StatefulWidget> createState() {
    return _AddContactViewState(AddContactController(
      DataContactRepository(),
      DataUserRepository(),
    ));
  }
}

class _AddContactViewState
    extends ViewState<AddContactView, AddContactController> {
  _AddContactViewState(AddContactController controller) : super(controller);

  @override
  Widget get view {
    Size size = MediaQuery.of(context).size;
    EdgeInsets padding = MediaQuery.of(context).padding;
    return Scaffold(
      key: globalKey,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              child: ControlledWidgetBuilder<AddContactController>(
                builder: (context, controller) {
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(height: padding.top + defaultSizedBoxPadding),
                        GestureDetector(
                            onTap: () {
                              controller.pickImage();
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
                                    child: Image(
                                    image:
                                        AssetImage("assets/images/select.png"),
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ))),
                        SizedBox(height: defaultSizedBoxPadding),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(PhoneBookTexts.addContact,
                                style: kLargeTitleStyle(kBlack)),
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
                                  hintText: 'Firstname',
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
                                  hintText: 'Lastname',
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
                                  hintText: 'E-mail',
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
                                  hintText: 'Phone Number',
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
                              controller.addContact();
                            },
                            text: PhoneBookTexts.addContact,
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
