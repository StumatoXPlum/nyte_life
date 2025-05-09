import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  const CustomBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 70.h, left: 30.w),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Icon(Icons.arrow_back, size: 20.sp),
            SizedBox(width: 5.w),
            Text(
              'Back',
              style: TextStyle(
                fontFamily: 'britti',
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
