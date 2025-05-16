import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EventsTab extends StatefulWidget {
  const EventsTab({super.key});

  @override
  State<EventsTab> createState() => _EventsTabState();
}

class _EventsTabState extends State<EventsTab> {
  final supabase = Supabase.instance.client;
  List<dynamic> bookings = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBookings();
  }

  Future<void> fetchBookings() async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    try {
      final response = await supabase
          .from('event_bookings')
          .select('*')
          .eq('user_id', user.id)
          .order('created_at', ascending: false);

      setState(() {
        bookings = response;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      print('Error fetching bookings: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Align(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      );
    }
    if (bookings.isEmpty) {
      return const Center(child: Text("No bookings yet."));
    }
    return ListView.builder(
      padding: EdgeInsets.only(
        bottom: 50.h,
        left: 16.w,
        right: 16.w,
        top: 20.h,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return Container(
          margin: EdgeInsets.only(bottom: 20.h),
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: Colors.grey[100],
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 6, spreadRadius: 5),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  booking['url'],
                  height: 100.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 12.h),
              _bookingInfo("Event", booking['event_title']),
              _bookingInfo("Date", booking['event_date']),
              _bookingInfo("Time", booking['event_time']),
              _bookingInfo("Location", booking['event_location']),
              _bookingInfo("Tickets", booking['number_of_tickets']),
              _bookingInfo("Total Paid", "Rs ${booking['total_price']}"),
              SizedBox(height: 12.h),
              DottedLine(),
              SizedBox(height: 12.h),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/barcode.png',
                  height: 50.h,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _bookingInfo(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
