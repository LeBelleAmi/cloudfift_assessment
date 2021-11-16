import 'package:cloudfift_assessment/constants/constants.dart';

class Validator {
  String? validateUsername(String userName) {
    if (userName.isEmpty) {
      return 'Username is required';
    } else if (!(regexEmail.hasMatch(userName))) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password is required';
    } else if (password.length < 6) {
      return 'Password should be 8 characters';
    }
    return null;
  }
}
