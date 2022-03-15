import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phone_book/src/app/constants.dart';
import 'package:phone_book/src/app/pages/auth/sign_up/sign_up_controller.dart';
import 'package:phone_book/src/app/texts.dart';
import 'package:phone_book/src/app/widgets/default_button.dart';
import 'package:phone_book/src/data/repositories/data_user_repository.dart';

class SignUpView extends View {
  @override
  State<StatefulWidget> createState() {
    return _SignUpViewState(SignUpController(DataUserRepository()));
  }
}

class _SignUpViewState extends ViewState<SignUpView, SignUpController> {
  _SignUpViewState(SignUpController controller) : super(controller);
  @override
  Widget get view {
    EdgeInsets padding = MediaQuery.of(context).padding;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: globalKey,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              child: ControlledWidgetBuilder<SignUpController>(
                builder: (context, controller) {
                  return Column(
                    children: [
                      SizedBox(height: padding.top + 22),
                      Center(
                        child: ControlledWidgetBuilder<SignUpController>(
                          builder: (context, controller) {
                            return GestureDetector(
                              onTap: () {
                                controller.pickImage();
                              },
                              child: Container(
                                  width: 150,
                                  height: 150,
                                  child: Image(
                                      image: AssetImage(
                                          "assets/images/select.png"))),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        padding: EdgeInsets.only(left: 15),
                        width: size.width - 44,
                        height: 56,
                        decoration: BoxDecoration(
                          border: Border.all(color: kBlack.withOpacity(0.3)),
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
                          border: Border.all(color: kBlack.withOpacity(0.3)),
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
                          border: Border.all(color: kBlack.withOpacity(0.3)),
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
                          border: Border.all(color: kBlack.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextFormField(
                          onChanged: (value) =>
                              controller.onPhoneNumberTextFieldChanged(value),
                          cursorColor: kPrimaryColor,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Phone Number',
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        padding: EdgeInsets.only(left: 15),
                        width: size.width - 44,
                        height: 56,
                        decoration: BoxDecoration(
                          border: Border.all(color: kBlack.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (value) =>
                              controller.onPasswordTextChanged(value),
                          cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Password',
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: size.width - 150,
                        // ignore: prefer_const_constructors
                        child: DefaultButton(
                          onPressed: () {
                            controller.createUser();
                          },
                          text: "Sign Up",
                          color: kPrimaryColor,
                        ),
                      ),
                      SizedBox(height: 5),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              // ignore: prefer_const_constructors
                              Text(
                                "Already have an acoount?",
                                // ignore: prefer_const_constructors
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Text(
                                " Sign In",
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.underline,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 110),
                        child: Text(
                          PhoneBookTexts.kctek,
                          textAlign: TextAlign.center,
                          // ignore: prefer_const_constructors
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50 + padding.bottom,
                      )
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
