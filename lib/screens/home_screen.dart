import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 150.h),
          Row(
            children: [
              SvgPicture.asset("assets/logo.svg", height: 130.h, width: 668.w),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.notifications_none_rounded, size: 100.sp),
                color: Color(0xffD3AF37),
              ),
              SizedBox(width: 20.w),
              Container(
                height: 100.h,
                width: 100.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0xffD3AF37), width: 2),
                ),
              ),
              SizedBox(width: 50.w),
            ],
          ),
        ],
      ),
    );
  }
}
