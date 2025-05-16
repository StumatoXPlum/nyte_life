import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/custom_widgets/custom_back_button.dart';
import '../../core/custom_widgets/custom_continue.dart';
import 'page_view_screen.dart';

class Preferences extends StatelessWidget {
  const Preferences({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double fontSize = size.width * 0.05;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomBackButton(onTap: () => Navigator.pop(context)),
          SizedBox(height: 70.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Text(
              "Please tell us a bit about your outing preferences",
              style: TextStyle(
                fontSize: fontSize * 1.6,
                fontWeight: FontWeight.bold,
                fontFamily: 'britti',
                height: 1.0,
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Text(
<<<<<<< HEAD
              "We want to gather data so we can curate a perfect nightlife experience that matches what you want :)",
              style: TextStyle(
                fontSize: fontSize,
                fontFamily: 'britti',
                height: 1.2,
              ),
=======
              "We want to gather Data so we can curate a perfect nightlife experience that matches what you want :)",
              style: TextStyle(fontSize: fontSize, fontFamily: 'britti', height: 1.2),
>>>>>>> origin/ankit_dev
            ),
          ),
          SizedBox(height: 200.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: CustomContinue(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PageViewScreen()),
                );
              },
<<<<<<< HEAD
              label: "Agree & Continue",
=======
              label: "Agree, Let's Do it",
>>>>>>> origin/ankit_dev
            ),
          ),
        ],
      ),
    );
  }
}
