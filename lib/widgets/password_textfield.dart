import 'package:cloudfift_assessment/constants/constants.dart';
import 'package:flutter/material.dart';

class PasswordEntryField extends StatelessWidget {
  final FormFieldSetter<String>? onSavedValue;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final String? errorText;
  final String? hintext;
  final TextInputAction? textInputAction;

  const PasswordEntryField(
      {this.onSavedValue,
      this.onChanged,
      this.controller,
      this.validator,
      this.errorText,
      this.hintext,
      this.textInputAction});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: TextFormField(
        obscureText: true,
        keyboardType: TextInputType.emailAddress,
        onChanged: onChanged,
        controller: controller,
        validator: validator,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: kDeepGrey,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            height: 1.5,
          ),
          hintText: hintext,
          errorText: errorText,
          filled: true,
          fillColor: kGrey.withOpacity(0.4),
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 1.5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
        ),
      ),
    );
  }
}
