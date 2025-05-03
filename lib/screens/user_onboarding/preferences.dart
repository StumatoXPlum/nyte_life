import 'package:flutter/material.dart';
import 'package:nytelife/core/custom_back_button.dart';
import 'package:nytelife/screens/user_onboarding/basic_info.dart';

class Preferences extends StatelessWidget {
  const Preferences({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double padding = size.width * 0.03;
    double fontSize = size.width * 0.05;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: size.width * 0.08),
            child: CustomBackButton(),
          ),
          SizedBox(height: size.height * 0.1),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding * 3),
            child: Text(
              "Please tell us a bit about your \nouting preferences",
              style: TextStyle(
                fontSize: fontSize * 1.2,
                fontWeight: FontWeight.bold,
                fontFamily: 'britti',
              ),
            ),
          ),
          SizedBox(height: size.height * 0.03),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding * 3),
            child: Text(
              "We want to gather Data so we can curate \na perfect nightlife experience \nthat matches what you want :)",
              style: TextStyle(fontSize: fontSize, fontFamily: 'britti'),
            ),
          ),
          SizedBox(height: size.height * 0.3),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding * 3),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BasicInfo()),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: padding,
                  vertical: padding,
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Agree, Let's Do it",
                      style: TextStyle(
                        fontSize: fontSize * 0.8,
                        fontFamily: 'britti',
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: size.width * 0.02),
                    Icon(
                      Icons.arrow_forward,
                      size: fontSize * 0.9,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
