// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget {
  final Widget leadingIcon;
  final Widget actionIcon;
  final Function leadingOnPressed;
  final Function actionOnPressed;
  final Color backgroundColor;
  final Color titleColor;
  final String title;

  DefaultAppBar({
    required this.leadingIcon,
    required this.actionIcon,
    required this.leadingOnPressed,
    required this.actionOnPressed,
    required this.backgroundColor,
    required this.titleColor,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    double topPadding = MediaQuery.of(context).padding.top;
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          bottom: BorderSide(
            color: Colors.black.withOpacity(0.02),
          ),
        ),
      ),
      width: size.width,
      height: 68 + topPadding,
      padding: EdgeInsets.only(
        top: topPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            style: ButtonStyle(
              overlayColor:
                  MaterialStateProperty.resolveWith((_) => Colors.transparent),
              padding: MaterialStateProperty.resolveWith(
                (_) => EdgeInsets.zero,
              ),
            ),
            child: leadingIcon,
            onPressed: () {
              leadingOnPressed();
            },
          ),
          Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextButton(
            style: ButtonStyle(
              overlayColor:
                  MaterialStateProperty.resolveWith((_) => Colors.transparent),
              padding: MaterialStateProperty.resolveWith(
                (_) => EdgeInsets.zero,
              ),
            ),
            child: actionIcon,
            onPressed: () {
              actionOnPressed();
            },
          ),
        ],
      ),
    );
  }
}
