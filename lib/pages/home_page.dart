import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ios_signin/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final FirebaseUser user;

  HomePage({this.user});

  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  void _signOut() async {
    await Provider.of<AuthProvider>(context).signOut();
  }

  Widget _body() {
    return new Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(top: 30.0, bottom: 15.0),
            child: Container(
              padding: EdgeInsets.only(top: 40),
              alignment: Alignment.center,
              child: Text(
                'Welcome ${widget.user?.email}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          _showSignOut()
        ],
      ),
    );
  }

  Widget _showSignOut() {
    return new Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: new RaisedButton(
        child: Text(
          'Sign out',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        onPressed: _signOut,
      ),
    );
  }
}
