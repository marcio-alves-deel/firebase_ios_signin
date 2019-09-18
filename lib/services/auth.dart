import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ios_signin/models/SignInData.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider with ChangeNotifier {
  static final AuthProvider _instance = AuthProvider.internal();
  AuthProvider.internal();
  factory AuthProvider() => _instance;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future signIn(SignInData data) async {
    try {
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
          email: data.email, password: data.password);
      notifyListeners();
      return result.user;
    } catch (e){
      throw new AuthException(e.code, e.message);
    }
  }

  Future signUp(SignInData data) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: data.email, password: data.password);
    notifyListeners();
    return result.user;
  }

  Future<FirebaseUser> getCurrentUser() async {
    return await _firebaseAuth.currentUser();
  }

  Future signOut() async {
    var result = await _firebaseAuth.signOut();
    notifyListeners();
    return result;
  }
}
