import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ios_signin/pages/home_page.dart';
import 'package:firebase_ios_signin/pages/signin_page.dart';
import 'package:firebase_ios_signin/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'helpers/navigate.dart';

void main() => runApp(ChangeNotifierProvider<AuthProvider>(
      child: MyApp(),
      builder: (BuildContext context) {
        return AuthProvider();
      },
    ));

class MyApp extends StatelessWidget {
  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routes,
      home: FutureBuilder(
        future: Provider.of<AuthProvider>(context).getCurrentUser(),
        builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return (snapshot.hasData)
                ? HomePage(user: snapshot.data)
                : SignInPage();
          } else {
            return _buildWaitingScreen();
          }
        },
      ),
    );
  }
}
