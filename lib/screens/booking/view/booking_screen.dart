import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nytelife/core/custom_bottom_bar.dart';
import 'package:nytelife/core/header_widget.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 50.h),
          HeaderWidget(),
          SizedBox(height: 20.h),
          ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                colors: [
                  Color(0xff6D5A1C),
                  Color(0xff9C8229),
                  Color(0xffD3AF37),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds);
            },
            child: Text(
              "Hurray! Your Booking is Done",
              style: TextStyle(
                fontSize: 24.sp,
                fontFamily: 'britti',
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 40.h),
          SvgPicture.asset(
            "assets/ticket.svg",
            height: 400.h,
            width: 200.w,
            fit: BoxFit.cover,
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CustomBottomBar()),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 30.w),
              decoration: BoxDecoration(
                color: Color(0xffD3AF37),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                "Back to Home",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'britti',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }
}
