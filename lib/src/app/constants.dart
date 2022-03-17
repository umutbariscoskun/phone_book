// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:phone_book/src/app/widgets/default_notification_banner.dart';
import 'package:phone_book/src/domain/types/enums/banner_type.dart';

const Color kBackGroundColor = Color(0xfff8f8ff);
const Color kPrimaryColor = Colors.blue;
const Color kTextBlack = Color(0xff2E2F37);
const Color kBlack = Colors.black;
const Color kWhite = Colors.white;
const kDisabledButtonColor = Color(0xffDADADA);
const Color kSecondaryGray = Color(0xff211F30);
const Color kErrorTextColor = Colors.red;
const Color kSuccessColor = Color(0xff5cb85c);

const double horizantalPadding = 18;
const double defaultSizedBoxPadding = 15;

const String profilePhotoPlaceHolder =
    "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";

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

// Banner
void kShowBanner(BannerType bannerType, String text, BuildContext context) {
  switch (bannerType) {
    case BannerType.INFO:
      return DefaultNotificationBanner(
        context: context,
        icon: Icon(Icons.info),
        text: text,
        color: Colors.yellow.shade700,
      ).show();

    case BannerType.ERROR:
      return DefaultNotificationBanner(
        context: context,
        icon: Icon(Icons.error),
        text: text,
        color: kErrorTextColor,
      ).show();

    case BannerType.SUCCESS:
      return DefaultNotificationBanner(
        context: context,
        icon: Icon(Icons.check),
        text: text,
        color: kSuccessColor,
      ).show();
  }
}
