import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nytelife/core/custom_back_button.dart';
import 'package:nytelife/screens/user_onboarding/cubit/on_boarding_cubit.dart';
import 'package:nytelife/screens/user_onboarding/page_view_screen.dart';

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
          SizedBox(height: 250.h),
          Padding(
            padding: EdgeInsets.only(left: 91.w),
            child: Text(
              "Please tell us a bit about your \nouting preferences",
              style: TextStyle(
                fontSize: 64.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'britti',
              ),
            ),
          ),
          SizedBox(height: 60.h),
          Padding(
            padding: EdgeInsets.only(left: 91.w),
            child: Text(
              "We want to gather Data so we can curate \na perfect nightlife experience \nthat matches what you want :)",
              style: TextStyle(fontSize: 48.sp, fontFamily: 'britti'),
            ),
          ),
          SizedBox(height: 600.h),
          Padding(
            padding: EdgeInsets.only(left: 91.w),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => BlocProvider(
                          create: (context) => OnboardingCubit(),
                          child: PageViewScreen(),
                        ),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 20.h),
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
                        fontSize: 48.sp,
                        fontFamily: 'britti',
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Icon(Icons.arrow_forward, size: 48.sp, color: Colors.white),
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
