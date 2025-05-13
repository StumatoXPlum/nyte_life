import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/custom_widgets/header_widget.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50.h),
            HeaderWidget(),
            SizedBox(height: 20.h),
            ShaderMask(
              shaderCallback: (bounds) {
                return const LinearGradient(
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
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontFamily: 'britti',
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 40.h),
            Center(
              child: SizedBox(
                width: 0.8.sw,
                height: 400.h,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/ticket.svg",
                      width: 0.8.sw,
                      height: 400.h,
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                      top: 80.h,
                      child: SvgPicture.asset(
                        'assets/qr.svg',
                        width: 120.w,
                        height: 120.h,
                      ),
                    ),
                    Positioned(
                      top: 230.h,
                      child: Text(
                        "The Lotus Restaurant",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Positioned(
                      bottom: 100.h,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "27th April",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            "12:30 PM",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }
}
