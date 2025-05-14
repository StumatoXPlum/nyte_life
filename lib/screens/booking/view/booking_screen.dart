import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/custom_widgets/header_widget.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  Future<List<Map<String, dynamic>>> fetchBookings() async {
    final client = Supabase.instance.client;

    final response = await client.from('bookings').select('*');

    final bookings = List<Map<String, dynamic>>.from(response);

    return bookings;
  }

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
                "Hurray! Your Bookings are Done",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontFamily: 'britti',
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 40.h),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchBookings(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final bookings = snapshot.data!;
                  return bookings.isNotEmpty
                      ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: bookings.length,
                        itemBuilder: (context, index) {
                          final booking = bookings[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
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
                                      booking['restaurant_name'] ??
                                          'No title available',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 110.h,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          booking['date'] ?? 'No date',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                        SizedBox(width: 12.w),
                                        Text(
                                          booking['time'] ?? 'No time',
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
                          );
                        },
                      )
                      : Padding(
                        padding: EdgeInsets.symmetric(vertical: 50.h),
                        child: Text(
                          'No bookings Yet.',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.black,
                          ),
                        ),
                      );
                } else {
                  return Text('No data available.');
                }
              },
            ),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }
}
