import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/custom_widgets/header_widget.dart';
import '../../../core/custom_widgets/heading_widget.dart';
import '../widgets/filter.dart';
import '../widgets/gigs_widget.dart';
import '../widgets/good_events.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50.h),
            HeaderWidget(),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Color(0xff6C5A1D)),
                  filled: true,
                  fillColor: Color(0xffF5EFE7),
                  hintText: 'Tell us what you are looking for',
                  hintStyle: TextStyle(
                    fontFamily: 'britti',
                    fontSize: 16.sp,
                    color: Color(0xff6C5A1D),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "Events that are\n too good to be missed!",
              style: TextStyle(
                fontFamily: 'britti',
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),
            GoodEventsWidget(),
            SizedBox(height: 20.h),
            HeadingWidget(heading: "Popular gigs Near You"),
            SizedBox(height: 20.h),
            Filter(),
            SizedBox(height: 20.h),
            GigsWidget(),
          ],
        ),
      ),
    );
  }
}
