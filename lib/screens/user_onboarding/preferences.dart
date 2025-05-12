import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/custom_widgets/custom_back_button.dart';
import '../../core/custom_widgets/custom_continue.dart';
import 'page_view_screen.dart';

class Preferences extends StatelessWidget {
  const Preferences({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomBackButton(onTap: () => Navigator.pop(context)),
          SizedBox(height: 70.h),
          Padding(
            padding: EdgeInsets.only(left: 30.w),
            child: Text(
              "Please tell us a bit about your \nouting preferences",
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'britti',
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Padding(
            padding: EdgeInsets.only(left: 30.w),
            child: Text(
              "We want to gather Data so we can curate \na perfect nightlife experience \nthat matches what you want :)",
              style: TextStyle(fontSize: 20.sp, fontFamily: 'britti'),
            ),
          ),
          SizedBox(height: 200.h),
          Padding(
            padding: EdgeInsets.only(left: 30.w),
            child: CustomContinue(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PageViewScreen()),
                );
              },
              label: "Agree, Let's Do it",
            ),
          ),
        ],
      ),
    );
  }
}
