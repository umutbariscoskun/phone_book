// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

const Color kBackGroundColor = Color(0xfff8f8ff);
const Color kPrimaryColor = Colors.blue;
const Color kTextBlack = Color(0xff2E2F37);
const Color kBlack = Colors.black;
const Color kWhite = Colors.white;
const kDisabledButtonColor = Color(0xffDADADA);
const Color kSecondaryGray = Color(0xff211F30);

const double horizantalPadding = 18;
const double defaultSizedBoxPadding = 15;

TextStyle kLargeTitleStyle(Color color) {
  return TextStyle(
    color: color,
    fontSize: 22,
    fontWeight: FontWeight.w600,
  );
}

TextStyle kTitleStyle(Color color) {
  return TextStyle(
    color: color,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );
}

TextStyle kContentStyleBold(Color color) {
  return TextStyle(
    color: color,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
}

TextStyle kContentStyleThin(Color color) {
  return TextStyle(
    color: color,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
}

TextStyle kHintTextStyle(Color color) {
  return TextStyle(
    color: color,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
}

TextStyle kLoginButtonTextStyle(Color color) {
  return TextStyle(
    color: color,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );
}
