import 'package:flutter/material.dart';

Widget formFieldWidget({
  String labelText,
  bool obscureText = false,
  validator,
  onSaved,
  keyboardType
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 22),
    child: TextFormField(
      obscureText: obscureText,
      style: TextStyle(color: Colors.black),
      onSaved: onSaved,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        enabledBorder: new UnderlineInputBorder(
          borderSide: new BorderSide(
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        labelText: labelText,
      ),
    ),
  );
}
