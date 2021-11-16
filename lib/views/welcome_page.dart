import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomePage extends StatefulWidget {
  final String userName;

  const WelcomePage({required this.userName});
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Container(
        height: size.height,
        width: size.width,
        padding:
            const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 24),
        child: Column(
          children: [
            Spacer(),
            SvgPicture.asset(
              'assets/images/celebration.svg',
              height: 250,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Welcome ${widget.userName}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                height: 1.5,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'You\'ve successfully logged into our app, congratulations!!!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal,
                height: 1.5,
              ),
            ),
            Spacer(),
          ],
        ),
      )),
    );
  }
}
