// screens/booking/view/booking_details.dart
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nytelife/core/custom_widgets/custom_bottom_bar.dart';
import 'package:nytelife/core/custom_widgets/custom_continue.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/date_picker.dart';
import '../widgets/time_picker.dart';

class BookingDetails extends StatefulWidget {
  final ValueChanged<String> onDateSlotChanged;
  final ValueChanged<String> onTimeSlotChanged;
  final Map<String, dynamic> dining;
  final String userId;

  const BookingDetails({
    super.key,
    required this.onDateSlotChanged,
    required this.onTimeSlotChanged,
    required this.dining,
    required this.userId,
  });

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _slotController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _specialReqController = TextEditingController();

  String selectedDate = '';
  String selectedTime = '';
  String numPeople = '';
  String name = '';
  String phoneNumber = '';
  String specialRequest = '';

  @override
  void dispose() {
    _dateController.dispose();
    _slotController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _specialReqController.dispose();
    super.dispose();
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Text(
        text,
        style: TextStyle(fontSize: 16.sp, fontFamily: 'britti'),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey.shade100,
      hintText: hint,
      hintStyle: TextStyle(
        fontFamily: 'britti',
        color: Colors.grey,
        fontWeight: FontWeight.normal,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Complete Your Reservation",
          style: TextStyle(fontFamily: 'britti'),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6.r),
                      child: Image.network(
                        widget.dining['image_url'],
                        height: 80.h,
                        width: 80.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.dining['title'],
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontFamily: 'britti',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.dining['rating'].toString(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: 'britti',
                          ),
                        ),
                        Text(
                          "(128 reviews)",
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                "Reservation Details",
                style: TextStyle(
                  fontFamily: 'britti',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              shadowContainer(
                child: Padding(
                  padding: EdgeInsets.all(14.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("Choose a Date"),
                      DateSlotField(
                        controller: _dateController,
                        onDateChanged: (value) {
                          widget.onDateSlotChanged(value);
                          setState(() => selectedDate = value);
                        },
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel("Time Slot"),
                                SizedBox(height: 2.h),
                                CustomTimeField(
                                  controller: _slotController,
                                  onTimeChanged: (value) {
                                    widget.onTimeSlotChanged(value);
                                    setState(() => selectedTime = value);
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel("Number of People"),
                                SizedBox(height: 2.h),
                                TextField(
                                  keyboardType: TextInputType.number,
                                  cursorColor: Colors.black,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'britti',
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration: _inputDecoration(""),
                                  onChanged:
                                      (value) =>
                                          setState(() => numPeople = value),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                "Personal Information",
                style: TextStyle(
                  fontFamily: 'britti',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              shadowContainer(
                child: Padding(
                  padding: EdgeInsets.all(14.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("Your Name"),
                      TextField(
                        controller: _nameController,
                        cursorColor: Colors.black,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'britti',
                        ),
                        decoration: _inputDecoration('Enter your Full Name'),
                        onChanged: (value) => setState(() => name = value),
                      ),
                      SizedBox(height: 16.h),
                      _buildLabel("Phone Number"),
                      TextField(
                        controller: _phoneController,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'britti',
                        ),
                        decoration: _inputDecoration('Enter your Phone Number'),
                        onChanged:
                            (value) => setState(() => phoneNumber = value),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              shadowContainer(
                child: Padding(
                  padding: EdgeInsets.all(14.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("Special Request (optional)"),
                      TextField(
                        controller: _specialReqController,
                        cursorColor: Colors.black,
                        maxLines: 3,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'britti',
                        ),
                        decoration: _inputDecoration(
                          "Any allergies, special ocassions, or specific seating preferences",
                        ),
                        onChanged:
                            (value) => setState(() => specialRequest = value),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              Align(
                alignment: Alignment.center,
                child: CustomContinue(
                  label: "Book Now",
                  onTap: () async {
                    if (selectedDate.isEmpty ||
                        selectedTime.isEmpty ||
                        numPeople.isEmpty ||
                        name.isEmpty ||
                        phoneNumber.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red.shade600,
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            'Please fill all required fields',
                            style: TextStyle(
                              fontFamily: 'britti',
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      );
                      return;
                    }

                    final response =
                        await Supabase.instance.client
                            .from('dining_bookings')
                            .insert({
                              'user_id': widget.userId,
                              'restaurant_name': widget.dining['title'],
                              'date': selectedDate,
                              'time': selectedTime,
                              'num_people': int.parse(numPeople),
                              'name': name,
                              'phone_number': phoneNumber,
                              'special_request': specialRequest,
                            })
                            .select()
                            .single();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => CustomBottomBar(
                              booking: response,
                              initialIndex: 2,
                            ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "By completing this reservation you agree to our ",
                      ),
                      TextSpan(
                        text: "reservation policy",
                        style: TextStyle(color: Color(0xffF3A712)),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                      TextSpan(
                        text:
                            ". A confirmation will be sent to your phone number.",
                      ),
                    ],
                  ),
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: 'britti',
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget shadowContainer({required Widget child}) {
  return Container(
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
    child: child,
  );
}
