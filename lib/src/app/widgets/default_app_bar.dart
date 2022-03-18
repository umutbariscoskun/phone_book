import 'package:flutter/material.dart';
import 'package:phone_book/src/app/constants.dart';
import 'package:phone_book/src/app/texts.dart';

class DefaultAppBar extends StatelessWidget {
  final String? appBarText;
  DefaultAppBar(this.appBarText);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    EdgeInsets padding = MediaQuery.of(context).padding;
    return Container(
      decoration: BoxDecoration(
        color: kWhite,
        border: Border(
          bottom: BorderSide(
            color: Colors.black.withOpacity(0.02),
          ),
        ),
      ),
      width: size.width,
      height: padding.top + 68,
      padding: EdgeInsets.only(
        top: padding.top,
        left: horizantalPadding,
        right: horizantalPadding,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
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
          appBarText != null
              ? Text(
                  appBarText!,
                  style: kTitleStyle(kBlack),
                )
              : Container(),
        ],
      ),
    );
  }
}
