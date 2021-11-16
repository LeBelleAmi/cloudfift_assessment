import 'dart:convert';
import 'dart:ui';

import 'package:cloudfift_assessment/constants/constants.dart';
import 'package:cloudfift_assessment/services/network_helper.dart';
import 'package:cloudfift_assessment/utilities/snackbar_utils.dart';
import 'package:cloudfift_assessment/utilities/validator.dart';
import 'package:cloudfift_assessment/views/welcome_page.dart';
import 'package:cloudfift_assessment/widgets/email_textfield.dart';
import 'package:cloudfift_assessment/widgets/password_textfield.dart';
import 'package:cloudfift_assessment/widgets/rounded_button.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String? _errorUserName, _errorPassword;
  bool _isLoading = false;

  _validateFields(String userName, String password) {
    bool valid = true;
    _errorUserName = Validator().validateUsername(userName);
    _errorPassword = Validator().validatePassword(password);
    if (_errorUserName == null && _errorPassword == null) {
      valid = true;
    } else {
      valid = false;
    }
    return valid;
  }

  _showLoading() {
    setState(() => _isLoading = true);
  }

  _hideLoading() {
    setState(() => _isLoading = false);
  }

  _navigateToWelcomePage(String userName) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => WelcomePage(
                  userName: userName,
                )));
  }

  _loginTheUserIntoTheApp() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      SnackBarUtilities().showErrorSnackBar(context,
          'You have no internet connection. please check and try again later.');
      return;
    }
    String userName = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    if (_validateFields(userName, password)) {
      _showLoading();
      await NetworkHelper.attemptLogin(userName, password).then((response) {
        if (response.statusCode == 200) {
          String name = jsonDecode(response.body)["user"]["username"];
          _navigateToWelcomePage(name);
        } else {
          _hideLoading();
          SnackBarUtilities().showErrorSnackBar(
              context, "An Unknown Error occured, while trying to log in.");
        }
      }, onError: (error) {
        _hideLoading();
        setState(() {
          _isLoading = false;
          SnackBarUtilities().showErrorSnackBar(context, error.toString());
        });
      });
    } else {
      _hideLoading();
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [kMainColorLight, kMainColorDark],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: EdgeInsets.fromLTRB(0, 55, 0, 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'LOGO',
                style: TextStyle(fontSize: 55, color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  padding: EdgeInsets.fromLTRB(20, 32, 20, 32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      EntryField(
                        hintext: 'Username ...',
                        errorText: _errorUserName,
                        controller: _usernameController,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              _errorUserName = null;
                            });
                          }
                        },
                      ),
                      PasswordEntryField(
                        hintext: 'Password ...',
                        errorText: _errorPassword,
                        controller: _passwordController,
                        textInputAction: TextInputAction.done,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              _errorPassword = null;
                            });
                          }
                        },
                      ),
                      Text(
                        'Forgot Password?',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      _isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: kMainColorDark,
                              ),
                            )
                          : RoundedButton(
                              pressState: () => _loginTheUserIntoTheApp(),
                              text: 'Login',
                            ),
                      Container(
                        margin: EdgeInsets.only(top: 16, right: 4, left: 4),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: 'Don\'t have an account? ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1.5,
                              ),
                              children: [
                                TextSpan(
                                    text: 'Register Now',
                                    style: TextStyle(
                                      color: kMainColorDark,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      height: 1.5,
                                    )),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        EdgeInsets.only(left: 20, right: 8, top: 8, bottom: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                        color: kWhite),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icons/google.svg',
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                  Text(
                    'OR',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 8, right: 20, top: 8, bottom: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomLeft: Radius.circular(30)),
                        color: kWhite),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icons/facebook.svg',
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
