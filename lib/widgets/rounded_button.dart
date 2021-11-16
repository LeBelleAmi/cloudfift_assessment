import 'package:cloudfift_assessment/constants/constants.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String? text;
  final VoidCallback? pressState;

  const RoundedButton({
    this.text,
    required this.pressState,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [kMainColorLight, kMainColorDark],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 4),
                    color: kMainColorDark.withOpacity(0.32),
                    blurRadius: 10)
              ]),
          child: TextButton(
              onPressed: pressState,
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 18, horizontal: 15),
              ),
              child: Text(
                text!,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    height: 1.3),
              )),
        ),
      ),
    );
  }
}
