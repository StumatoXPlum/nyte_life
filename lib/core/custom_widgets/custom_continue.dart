import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomContinue extends StatelessWidget {
  final VoidCallback onTap;
  final String? label;

  const CustomContinue({super.key, required this.onTap, this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.w,
      height: 40.h,
      child: ElevatedButton(
        onPressed: () {
          HapticFeedback.selectionClick();
          onTap();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 4,
          shadowColor: Colors.black54,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label ?? 'Continue',
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: 'britti',
                color: Colors.white,
              ),
            ),
            Icon(Icons.arrow_forward, size: 16.sp, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
