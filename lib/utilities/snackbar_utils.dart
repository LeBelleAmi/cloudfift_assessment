import 'package:flutter/material.dart';

class SnackBarUtilities {
  SnackBarUtilities();

  showErrorSnackBar(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(errorMessage),
        duration: Duration(milliseconds: 3000),
        elevation: 6.0,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
