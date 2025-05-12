import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nytelife/screens/user_onboarding/cubit/on_boarding_cubit.dart';
import '../../screens/profile/profile.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final address = context.select(
      (OnboardingCubit cubit) => cubit.state.address,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset("assets/logo.svg", height: 40.h, width: 100.w),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications_none_rounded, size: 30.sp),
              color: const Color(0xffD3AF37),
            ),
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              },
              child: Container(
                height: 40.h,
                width: 40.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xffD3AF37), width: 2),
                ),
              ),
            ),
            SizedBox(width: 20.w),
          ],
        ),
        SizedBox(height: 5.h),
        Padding(
          padding: EdgeInsets.only(left: 30.w),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff6D5A1C), Color(0xffD3AF37)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(36.r),
            ),
            padding: EdgeInsets.all(1.5),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: const Color(0xffEDE1C2),
                borderRadius: BorderRadius.circular(32.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/arrow.svg',
                    height: 15.h,
                    width: 15.w,
                    fit: BoxFit.scaleDown,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    address ?? 'Location not set',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontFamily: 'britti',
                      color: Color(0xff6C5A1D),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
