import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  const CustomBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 273.h, left: 91.w),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Icon(Icons.arrow_back, size: 58.sp),
            SizedBox(width: 10.w),
            Text(
              'Back',
              style: TextStyle(
                fontFamily: 'britti',
                fontWeight: FontWeight.bold,
                fontSize: 60.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
