import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../user_onboarding/preferences.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Lottie.asset('assets/animations/light.json', fit: BoxFit.cover),
          SizedBox(height: 30.h),
          SvgPicture.asset('assets/event.svg', height: 800.h, width: 400.w),
          const Spacer(),
          SvgPicture.asset('assets/logo.svg', height: 130.h, width: 668.w),
          SizedBox(height: 109.h),
          buildContainer(
            "assets/call.svg",
            "Continue with Phone",
            const Color(0xffD3AF37),
            const Color(0xffD3AF37),
            Colors.white,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Preferences()),
              );
            },
          ),
          SizedBox(height: 56.h),
          buildContainer(
            "assets/apple.svg",
            "Continue with Apple",
            Colors.black,
            Colors.white,
            Colors.black,
            () {},
          ),
          SizedBox(height: 80.h),
          Container(
            height: 200.h,
            width: double.infinity,
            decoration: const BoxDecoration(color: Color(0xffD3AF37)),
          ),
        ],
      ),
    );
  }
}

Widget buildContainer(
  String svgPath,
  String title,
  Color borderColor,
  Color textColor,
  Color containerColor,
  VoidCallback? onTap,
) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 122.w),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        height: 172.h,
        padding: EdgeInsets.symmetric(horizontal: 60.w),
        decoration: BoxDecoration(
          color: containerColor,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(29.r),
        ),
        child: Row(
          children: [
            SvgPicture.asset(svgPath, height: 54.h, width: 48.w),
            SizedBox(width: 50.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 54.sp,
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
