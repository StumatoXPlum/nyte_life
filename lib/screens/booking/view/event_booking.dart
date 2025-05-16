import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../../core/custom_widgets/custom_bottom_bar.dart';
import '../../../core/custom_widgets/custom_continue.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EventBooking extends StatefulWidget {
  final Map<String, dynamic> event;

  const EventBooking({super.key, required this.event});

  @override
  State<EventBooking> createState() => _EventBookingState();
}

class _EventBookingState extends State<EventBooking> {
  int numberOfTickets = 1;

  String formatDateWithSuffix(String date) {
    try {
      final parsedDate = DateTime.parse(date);
      final day = parsedDate.day;
      final suffix =
          (day >= 11 && day <= 13)
              ? 'th'
              : ['st', 'nd', 'rd'][day % 10 - 1 < 3 ? day % 10 - 1 : 0];
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

  Future<void> saveBookingToSupabase() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("User not logged in")));
      return;
    }
    await supabase.from('event_bookings').insert({
      'user_id': user.id,
      'event_title': widget.event['title'] ?? '',
      'event_fee': widget.event['event_fee'].toString(),
      'event_date': widget.event['date'] ?? '',
      'event_time': widget.event['time'] ?? '',
      'event_location': widget.event['location'] ?? '',
      'number_of_tickets': numberOfTickets.toString(),
      'total_price':
          (numberOfTickets * int.parse(widget.event['event_fee'].toString()))
              .toString(),
              'url': widget.event['url'] ?? '',
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const CustomBottomBar(initialIndex: 2),
        settings: const RouteSettings(arguments: 'Events'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final event = widget.event;
    final fee = int.tryParse(event['event_fee'].toString()) ?? 0;
    final totalPrice = numberOfTickets * fee;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Book Event", style: TextStyle(fontFamily: 'britti')),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                event['url'],
                height: 200.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: Text(
                    event['title'] ?? 'No Title',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'britti',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    '★ ${event['rating'] ?? 'N/A'}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontFamily: 'britti',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Container(
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
            SizedBox(height: 20.h),
            Text(
              'Number of Tickets',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'britti',
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap:
                      numberOfTickets > 1
                          ? () => setState(() => numberOfTickets--)
                          : null,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          numberOfTickets > 1 ? Colors.black : Colors.grey[300],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(10.r),
                    child: Icon(Icons.remove, color: Colors.white, size: 24.sp),
                  ),
                ),
                SizedBox(width: 24.w),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 32.w,
                    vertical: 16.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: Color(0xFFF6F6F6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    '$numberOfTickets',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'britti',
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(width: 24.w),
                GestureDetector(
                  onTap: () => setState(() => numberOfTickets++),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(10.r),
                    child: Icon(Icons.add, color: Colors.white, size: 24.sp),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Price',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'britti',
                  ),
                ),
                Text(
                  'Rs $totalPrice',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'britti',
                  ),
                ),
              ],
            ),
            Divider(),
            SizedBox(height: 20.h),
            Align(
              alignment: Alignment.center,
              child: CustomContinue(
                onTap: saveBookingToSupabase,
                label: "Confirm Booking",
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
