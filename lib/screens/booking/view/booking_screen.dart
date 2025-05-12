import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/custom_widgets/custom_bottom_bar.dart';
import '../../../core/custom_widgets/header_widget.dart';

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
          Stack(
            children: [
              SvgPicture.asset(
                "assets/ticket.svg",
                height: 400.h,
                width: 200.w,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 80.h,
                left: 80.w,
                child: SvgPicture.asset(
                  'assets/qr.svg',
                  height: 150.h,
                  width: 150.w,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 250.h,
                left: 60.w,
                child: Text(
                  "The Lotus Restaurant",
                  style: TextStyle(color: Colors.black, fontSize: 22.sp),
                ),
              ),
              Positioned(
                left: 100.w,
                bottom: 100.h,
                child: Row(
                  children: [
                    Text("27th April", style: TextStyle(color: Colors.black)),
                    SizedBox(width: 8.w),
                    Text("12:30 PM", style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
            ],
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
