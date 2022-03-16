import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:lottie/lottie.dart';
import 'package:phone_book/src/app/constants.dart';
import 'package:phone_book/src/app/pages/home/home_view.dart';
import 'package:phone_book/src/app/pages/splash/splash_controller.dart';
import 'package:phone_book/src/app/texts.dart';

class SplashView extends View {
  @override
  State<StatefulWidget> createState() {
    return _SplashViewState(SplashController());
  }
}

class _SplashViewState extends ViewState<SplashView, SplashController> {
  _SplashViewState(SplashController controller) : super(controller);

  @override
  Widget get view {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: globalKey,
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      height: size.height - 100,
                      child: Center(
                        child: Lottie.asset('assets/animations/loading.json'),
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      PhoneBookTexts.kctek,
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
