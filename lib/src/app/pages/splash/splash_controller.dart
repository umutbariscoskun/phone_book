import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:phone_book/src/app/pages/auth/sign_in/sign_in_view.dart';
import 'package:phone_book/src/app/pages/home/home_view.dart';

class SplashController extends Controller {
  @override
  void onInitState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Future.delayed(Duration(seconds: 2)).then((value) =>
            Navigator.pushAndRemoveUntil(
                getContext(),
                CupertinoPageRoute(builder: (context) => SignInView()),
                (route) => false));
      } else {
        Future.delayed(Duration(seconds: 5)).then((value) =>
            Navigator.pushAndRemoveUntil(
                getContext(),
                CupertinoPageRoute(builder: (context) => HomeView()),
                (route) => false));
      }
    });
    super.onInitState();
  }

  @override
  void initListeners() {
    // TODO: implement initListeners
  }
}
