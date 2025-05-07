import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomContinue extends StatelessWidget {
  final VoidCallback onTap;
  const CustomContinue({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 476.w,
        height: 111.h,
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(36.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Continue",
              style: TextStyle(
                fontSize: 48.sp,
                fontFamily: 'britti',
                color: Colors.white,
              ),
            ),
            Icon(Icons.arrow_forward, size: 48.sp, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
