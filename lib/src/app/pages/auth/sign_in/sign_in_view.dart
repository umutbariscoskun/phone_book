import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phone_book/src/app/constants.dart';
import 'package:phone_book/src/app/pages/auth/sign_in/sign_in_controller.dart';
import 'package:phone_book/src/app/pages/auth/sign_up/sign_up_view.dart';
import 'package:phone_book/src/app/texts.dart';
import 'package:phone_book/src/app/widgets/default_button.dart';
import 'package:phone_book/src/data/repositories/data_user_repository.dart';

class SignInView extends View {
  @override
  State<StatefulWidget> createState() {
    return _SignInViewState(SignInController(DataUserRepository()));
  }
}

class _SignInViewState extends ViewState<SignInView, SignInController> {
  _SignInViewState(SignInController controller) : super(controller);
  @override
  Widget get view {
    Size size = MediaQuery.of(context).size;
    EdgeInsets padding = MediaQuery.of(context).padding;
    return Scaffold(
      key: globalKey,
      body: Column(
        children: [
          SizedBox(height: padding.top + 50),
          Expanded(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              child: Column(
                children: [
                  ControlledWidgetBuilder<SignInController>(
                    builder: (context, controller) {
                      return Center(
                          child: Column(
                        children: [
                          Opacity(
                            opacity: 1,
                            child: Container(
                              height: 200,
                              width: 200,
                              child: SvgPicture.asset(
                                "assets/images/welcome.svg",
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
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
                            child: DefaultButton(
                              onPressed: () => controller.signIn(),
                              text: "Sign In",
                              color: kPrimaryColor,
                            ),
                          ),
                          SizedBox(height: 5),
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => SignUpView(),
                                ),
                              );
                            },
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have an account yet?",
                                    style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Text(
                                    " Sign Up",
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
                            margin: EdgeInsets.only(top: 170),
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
                        ],
                      ));
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
