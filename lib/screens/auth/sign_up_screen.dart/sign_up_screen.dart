import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nytelife/screens/auth/phone/phone_number.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SvgPicture.asset(
            'assets/splash.svg',
            height: 200.h,
            width: 200.w,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 50.h),
          buildContainer(
            "assets/call.svg",
            "Continue with Phone",
            const Color(0xffD3AF37),
            Colors.white,
            const Color(0xffD3AF37),
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PhoneNumber()),
              );
            },
          ),
          // SizedBox(height: 20.h),
          // buildContainer(
          //   "assets/apple.svg",
          //   "Continue with Apple",
          //   Colors.black,
          //   Colors.white,
          //   Colors.black,
          //   () {},
          // ),
          SizedBox(height: 30.h),
          Text(
            "By entering information, I agree to Hush's Terms of Service, Non-\ndiscrimination Policy and Payments Terms of Service and \nacknowledge the Privacy Policy.",
            style: TextStyle(
              fontSize: 12.sp,
              fontFamily: 'britti',
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40.h),
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
    padding: EdgeInsets.symmetric(horizontal: 50.w),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.h,
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        decoration: BoxDecoration(
          color: containerColor,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              svgPath,
              height: 24.h,
              width: 28.w,
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
            SizedBox(width: 25.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 20.sp,
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
