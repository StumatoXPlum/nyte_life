import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nytelife/screens/user_onboarding/preferences.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SvgPicture.asset(
            'assets/logo.svg',
            height: size.height * 0.06,
            width: size.width * 0.06,
          ),
          SizedBox(height: size.height * 0.03),
          buildContainer(
            context,
            "assets/call.svg",
            "Continue with Phone",
            Color(0xffD3AF37),
            Color(0xffD3AF37),
            Colors.white,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Preferences()),
              );
            },
          ),
          SizedBox(height: size.height * 0.02),
          buildContainer(
            context,
            "assets/apple.svg",
            "Continue with Apple",
            Colors.black,
            Colors.white,
            Colors.black,
            () {},
          ),
          SizedBox(height: size.height * 0.02),
          Container(
            height: size.height * 0.1,
            width: double.infinity,
            decoration: BoxDecoration(color: Color(0xffD3AF37)),
          ),
        ],
      ),
    );
  }
}

Widget buildContainer(
  context,
  String svgPath,
  String title,
  Color borderColor,
  Color textColor,
  Color containerColor,
  VoidCallback? onTap,
) {
  final Size size = MediaQuery.of(context).size;
  double padding = size.width * 0.03;
  double fontSize = size.width * 0.05;
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: padding * 4),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: padding * 2,
          vertical: padding * 1.5,
        ),
        decoration: BoxDecoration(
          color: containerColor,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              svgPath,
              height: size.width * 0.05,
              width: size.width * 0.05,
            ),
            SizedBox(width: size.width * 0.05),
            Text(
              title,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
                fontFamily: 'britti',
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
