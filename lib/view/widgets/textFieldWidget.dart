import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final bool isObscure;
  final String? hintText;

  TextFieldWidget({this.controller, this.isObscure = false, this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: this.controller,
      obscureText: this.isObscure,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 1),
          border: new OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          fillColor: Colors.grey[300],
          filled: true,
          errorStyle: TextStyle(color: Colors.red),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.red),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.transparent, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          prefixIcon: Icon(Icons.mail),
          hintText: this.hintText),
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(fontSize: 18),
    );
  }
}
