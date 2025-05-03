import 'package:flutter/material.dart';
import 'package:nytelife/core/custom_back_button.dart';
import 'package:nytelife/core/custom_continue.dart';

class BubbleScreen extends StatelessWidget {
  const BubbleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double padding = size.width * 0.05;
    double fontSize = size.width * 0.045;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding * 2),
        child: Column(
          children: [
            CustomBackButton(),
            SizedBox(height: size.height * 0.1),
            Text(
              "Hey John! Thanks for choosing us",
              style: TextStyle(
                fontSize: fontSize * 1.3,
                fontFamily: 'britti',
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              "Deselect the bubble if it doesn't \napply to you",
              style: TextStyle(
                color: Color(0xffD3AF37),
                fontSize: fontSize * 1,
                fontFamily: 'britti',
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            Align(
              alignment: Alignment.center,
              child: CustomContinue(onTap: () {}),
            ),
            SizedBox(height: size.height * 0.05),
          ],
        ),
      ),
    );
  }
}
