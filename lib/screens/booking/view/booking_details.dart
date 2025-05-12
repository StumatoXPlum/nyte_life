import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nytelife/screens/booking/view/booking_screen.dart';
import '../../../core/custom_widgets/header_widget.dart';
import '../widgets/date_picker.dart';
import '../widgets/time_picker.dart';

class BookingDetails extends StatefulWidget {
  final ValueChanged<String> onDateSlotChanged;
  final ValueChanged<String> onTimeSlotChanged;

  const BookingDetails({
    super.key,
    required this.onDateSlotChanged,
    required this.onTimeSlotChanged,
  });

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _slotController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 50.h),
          HeaderWidget(),
          SizedBox(height: 40.h),
          Text(
            "Please Enter Your Details",
            style: TextStyle(
              fontFamily: 'britti',
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Choose a Date",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'britti',
                  ),
                ),
                SizedBox(
                  width: 150.w,
                  child: DateSlotField(
                    controller: _dateController,
                    onDateChanged: widget.onDateSlotChanged,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Time Slot",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'britti',
                  ),
                ),
                SizedBox(
                  width: 150.w,
                  child: CustomTimeField(
                    controller: _slotController,
                    onTimeChanged: widget.onTimeSlotChanged,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "No of People",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'britti',
                  ),
                ),
                SizedBox(
                  width: 150.w,
                  child: TextField(
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'britti',
                      fontWeight: FontWeight.bold,
                    ),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff202938)),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff202938)),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookingScreen()),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 30.w),
              decoration: BoxDecoration(
                color: Color(0xffD3AF37),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                "Book Now",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'britti',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }
}
