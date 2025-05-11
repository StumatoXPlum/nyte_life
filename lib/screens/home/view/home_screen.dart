import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nytelife/core/header_widget.dart';
import 'package:nytelife/screens/home/widgets/events_near_you_widget.dart';
import 'package:nytelife/screens/home/widgets/trending_deals_widget.dart';

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
            TrendingDealsWidget(),
            SizedBox(height: 20.h),
            EventsNearYouWidget(),
          ],
        ),
      ),
    );
  }
}
