import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DiningTab extends StatelessWidget {
  const DiningTab({super.key});

  Future<List<Map<String, dynamic>>> fetchBookings() async {
    final client = Supabase.instance.client;
    final response = await client.from('dining_bookings').select('*');
    return List<Map<String, dynamic>>.from(response);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchBookings(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final diningBookings = snapshot.data!;
          return diningBookings.isNotEmpty
              ? ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: diningBookings.length,
                itemBuilder: (context, index) {
                  final booking = diningBookings[index];
                  // Parsing date string
                  DateTime? parsedDate;
                  try {
                    parsedDate = DateTime.parse(booking['date']);
                  } catch (_) {
                    parsedDate = null;
                  }
                  String getDaySuffix(int day) {
                    if (day >= 11 && day <= 13) {
                      return 'th';
                    }
                    switch (day % 10) {
                      case 1:
                        return 'st';
                      case 2:
                        return 'nd';
                      case 3:
                        return 'rd';
                      default:
                        return 'th';
                    }
                  }

                  // Formatting date like "25th May"
                  String formattedDate = 'No date';
                  if (parsedDate != null) {
                    final day = parsedDate.day;
                    final suffix = getDaySuffix(day);
                    final month = DateFormat.MMMM().format(
                      parsedDate,
                    ); // Full month name, e.g., May
                    formattedDate = '$day$suffix $month';
                  }

                  // Parsing and formatting time
                  String formattedTime = 'No time';
                  try {
                    // Assuming time stored in 24-hour format like "20:00"
                    final timeParts = (booking['time'] ?? '').split(':');
                    if (timeParts.length >= 2) {
                      final hour = int.parse(timeParts[0]);
                      final minute = int.parse(timeParts[1]);
                      final time = DateTime(0, 0, 0, hour, minute);
                      formattedTime = DateFormat.jm().format(
                        time,
                      ); // e.g., 8:00 PM
                    }
                  } catch (_) {
                    // fallback to original if parsing fails
                    formattedTime = booking['time'] ?? 'No time';
                  }
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        "assets/ticket.png",
                        width: 300.w,
                        height: 250.h,
                      ),
                      Positioned(
                        top: 30.h,
                        child: Image.asset(
                          'assets/barcode.png',
                          width: 120.w,
                          height: 80.h,
                        ),
                      ),
                      Positioned(
                        top: 100.h,
                        child: Text(
                          booking['restaurant_name'] ?? 'No title available',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Positioned(
                        top: 130.h,
                        child: Text(
                          formattedDate,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 150.h,
                        child: Text(
                          formattedTime,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 50.h,
                        child: Text(
                          'Booking by: ${booking['name'] ?? 'No name'}',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              )
              : Padding(
                padding: EdgeInsets.symmetric(vertical: 50.h),
                child: Text(
                  'No bookings yet.',
                  style: TextStyle(fontSize: 18.sp, color: Colors.black),
                ),
              );
        } else {
          return const Text('No data available.');
        }
      },
    );
  }
}
