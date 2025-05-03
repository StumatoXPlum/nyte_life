import 'package:flutter/material.dart';
import 'package:nytelife/screens/user_onboarding/basic_info.dart';
import 'package:nytelife/screens/user_onboarding/drinking_preferences.dart';
import 'package:nytelife/screens/user_onboarding/food_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({super.key});

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  final PageController controller = PageController();

  int _currentPage = 0;

  void _goToNextPage() {
    if (_currentPage < 2) {
      controller.animateToPage(
        ++_currentPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      controller.animateToPage(
        --_currentPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: controller,
              children: [
                BasicInfo(goToNext: _goToNextPage, pageController: controller),
                FoodPreferences(
                  goToNext: _goToNextPage,
                  goToPrevious: _goToPreviousPage,
                  pageController: controller,
                ),
                DrinkingPreferences(
                  goToPrevious: _goToPreviousPage,
                  pageController: controller,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomPageIndicator extends StatelessWidget {
  final PageController controller;
  final int pageCount;

  const CustomPageIndicator({
    super.key,
    required this.controller,
    required this.pageCount,
  });

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: pageCount,
      effect: WormEffect(
        dotWidth: 30.0,
        dotHeight: 8.0,
        spacing: 8.0,
        dotColor: Color(0xffF2DB8F),
        activeDotColor: Color(0xffD3AF37),
      ),
    );
  }
}
