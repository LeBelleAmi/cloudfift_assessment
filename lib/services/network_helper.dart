import 'dart:io';

import 'package:cloudfift_assessment/services/api_url.dart';
import 'package:cloudfift_assessment/services/network_exception.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  String url;

  NetworkHelper(this.url);

  static Future<http.Response> attemptLogin(
      String email, String password) async {
    try {
      var response =
          await http.post(Uri.parse(APIPathHelper().kAuthLogin), body: {
        "email": email,
        "password": password,
      });
      return response;
    } on SocketException {
      throw FailureException(
          'You have no internet connection. please check and try again.');
    } on HttpException {
      throw FailureException('404, page not found, please try again.');
    } on FormatException {
      throw FailureException('Bad request, please try again.');
    }
  }
}
