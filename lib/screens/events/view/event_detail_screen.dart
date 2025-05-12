import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nytelife/core/custom_widgets/header_widget.dart';
import 'package:nytelife/screens/booking/view/booking_details.dart';

class EventDetailScreen extends StatelessWidget {
  final Map<String, dynamic> event;

  const EventDetailScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final customPadding = EdgeInsets.symmetric(horizontal: 20.w);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50.h),
          HeaderWidget(),
          SizedBox(height: 20.h),
          Padding(
            padding: customPadding,
            child: Text(
              event['title'],
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'britti',
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: customPadding,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                event['url'],
                height: 200.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: customPadding,
            child: Text(
              event['description'],
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black87,
                fontFamily: 'britti',
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: customPadding,
            child: Text(
              'Reviews',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'britti',
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: customPadding,
            child: Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Shekhar Patel",
                        style: TextStyle(
                          fontFamily: 'britti',
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '★ 4.2',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: 'britti',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Staff is very nice and helpful",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 28.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => BookingDetails(
                          onDateSlotChanged: (String selectedDate) {},
                          onTimeSlotChanged: (String selectedTime) {},
                        ),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 30.w),
                decoration: BoxDecoration(
                  color: Color(0xffD3AF37),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  "Book a Table",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'britti',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
