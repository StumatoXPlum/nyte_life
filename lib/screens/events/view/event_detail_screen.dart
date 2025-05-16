import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../core/custom_widgets/custom_continue.dart';
import '../../booking/view/event_booking.dart';

class EventDetailScreen extends StatelessWidget {
  final Map<String, dynamic> event;

  const EventDetailScreen({super.key, required this.event});

  String formatDateWithSuffix(String date) {
    try {
      final parsedDate = DateTime.parse(date);
      final day = parsedDate.day;

      String suffix;
      if (day >= 11 && day <= 13) {
        suffix = 'th';
      } else {
        switch (day % 10) {
          case 1:
            suffix = 'st';
            break;
          case 2:
            suffix = 'nd';
            break;
          case 3:
            suffix = 'rd';
            break;
          default:
            suffix = 'th';
        }
      }

      final formattedDate = DateFormat("MMMM yyyy").format(parsedDate);
      return '$day$suffix $formattedDate';
    } catch (e) {
      return 'Invalid date';
    }
  }

  String formatTime(String time) {
    try {
      final parsedTime = DateFormat("HH:mm").parse(time);
      return DateFormat("h:mm a").format(parsedTime).toLowerCase();
    } catch (e) {
      return 'Invalid time';
    }
  }

  @override
  Widget build(BuildContext context) {
    final customPadding = EdgeInsets.symmetric(horizontal: 20.w);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.network(
                    event['url'],
                    height: 300.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 20.w,
                  top: 50.h,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 24.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: customPadding,
                    child: Text(
                      event['title'],
                      style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'britti',
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Padding(
                  padding: customPadding,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      '★ ${event['rating'].toString()}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'britti',
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),
            Padding(
              padding: customPadding,
              child: Text(
                event['description'],
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.black87,
                  fontFamily: 'britti',
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: customPadding,
              child: Text(
                'Event Details',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'britti',
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  spacing: 12.h,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/fee.svg',
                          height: 35.h,
                          width: 35.w,
                        ),
                        SizedBox(width: 8.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Event Fee",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'britti',
                              ),
                            ),
                            Text(
                              'Rs ${event['event_fee'] ?? 'Not avaibale'} /per person',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontFamily: 'britti',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/calender.svg',
                          height: 35.h,
                          width: 35.w,
                        ),
                        SizedBox(width: 8.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(formatDateWithSuffix(event['date'] ?? '')),
                            Text(formatTime(event['time'] ?? '')),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/loc.svg',
                          height: 35.h,
                          width: 35.w,
                        ),
                        SizedBox(width: 8.w),
                        Text(event['location'] ?? 'Not avaibale'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Align(
              alignment: Alignment.center,
              child: CustomContinue(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventBooking(event: event),
                    ),
                  );
                },
                label: 'Book Event',
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
