import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/custom_widgets/header_widget.dart';
import '../../../core/custom_widgets/heading_widget.dart';
import '../widgets/custom_filter.dart';
import '../widgets/events_near_you_widget.dart';
import '../widgets/trending_deals_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50.h),
            HeaderWidget(),
            SizedBox(height: 20.h),
            Text("Trending Deals", style: TextStyle(fontSize: 30.sp)),
            SizedBox(height: 10.h),
            TrendingDealsWidget(),
            SizedBox(height: 20.h),
            HeadingWidget(heading: "Places Near You"),
            SizedBox(height: 20.h),
            CustomFilter(),
            SizedBox(height: 20.h),
            EventsNearYouWidget(),
          ],
        ),
      ),
    );
  }
}
