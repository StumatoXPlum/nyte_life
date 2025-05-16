import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/custom_widgets/header_widget.dart';
import '../../../core/custom_widgets/heading_widget.dart';
import '../widgets/dining_near_you.dart';
import '../widgets/trending_dining_deals.dart';

class DiningScreen extends StatelessWidget {
  const DiningScreen({super.key});

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
            SizedBox(height: 22.h),
            Text(
              "Trending Deals",
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            TrendingDiningDeals(),
            SizedBox(height: 20.h),
            HeadingWidget(heading: "Places Near You"),
            SizedBox(height: 20.h),
            DiningNearYouWidget(),
          ],
        ),
      ),
    );
  }
}
