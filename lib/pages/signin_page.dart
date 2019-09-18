import 'package:firebase_ios_signin/services/auth.dart';
import 'package:firebase_ios_signin/models/SignInData.dart';
import 'package:firebase_ios_signin/widgets/form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  _SignInPageState createState() => new _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  SignInData _signIn = new SignInData();

  void _validateAndSignIn() async {
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        await Provider.of<AuthProvider>(context).signIn(_signIn);
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  void _validateAndCreate() async {
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        await Provider.of<AuthProvider>(context).signUp(_signIn);
      } catch (e) {
        if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE')
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: new Text('Email already in use'),
          ));
      }
    }
  }

  String _validatePassword(String value) {
    if (value.length < 8) {
      return 'The Password must be at least 8 size long.';
    }

    return null;
  }

  String _validateEmail(String value) {
    if (!(value.length > 0 && value.contains("@") && value.contains("."))) {
      return 'The E-mail Address must be a valid email address.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: _showBody()),
    );
  }

  Widget _showBody() {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(16.0),
            child: new Form(
              key: _formKey,
              child: new ListView(
                shrinkWrap: true,
                children: <Widget>[
                  _showHeader(),
                  _showEmailInput(),
                  _showPasswordInput(),
                  _showActions()
                ],
              ),
            )),
      ],
    );
  }

  Widget _showHeader() {
    return new Padding(
      padding: const EdgeInsets.only(top: 30.0, bottom: 15.0),
      child: Container(
        padding: EdgeInsets.only(top: 40),
        alignment: Alignment.center,
        child: Text(
          'Sign In Firebase',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .title
              .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _showActions() {
    return new Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: new RaisedButton(
            child: Text(
              'Sign in',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            onPressed: _validateAndSignIn,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
          child: Text(
            'Or',
            textAlign: TextAlign.center,
          ),
        ),
        new RaisedButton(
          onPressed: _validateAndCreate,
          child: Text('Create Account', style: TextStyle(fontSize: 20)),
        ),
      ],
    );
  }

  Widget _showEmailInput() {
    return formFieldWidget(
      labelText: 'Email',
      validator: _validateEmail,
      onSaved: (String value) {
        this._signIn.email = value.trim();
      },
    );
  }

  Widget _showPasswordInput() {
    return formFieldWidget(
      labelText: 'Password',
      validator: _validatePassword,
      onSaved: (String value) {
        this._signIn.password = value;
      },
    );
  }
}
