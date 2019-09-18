import 'package:firebase_ios_signin/pages/home_page.dart';
import 'package:firebase_ios_signin/pages/signin_page.dart';
import 'package:flutter/material.dart';

var routes = <String, WidgetBuilder>{
  "/SignInPage": (BuildContext context) => SignInPage(),
  "/HomePage": (BuildContext context) => HomePage(),
};


class Navigate {
  static void switchToLogin(BuildContext context) {
    Navigator.pushNamed(context, "/SignInPage");
  }

  static void switchToHome(BuildContext context) {
    Navigator.pushNamed(context, "/HomePage");
  }
}