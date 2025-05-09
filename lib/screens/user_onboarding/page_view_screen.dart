import 'package:flutter/material.dart';
import 'basic_info/view/basic_info.dart';
import 'drinking_preferences.dart';
import 'food_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({super.key});

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  final PageController controller = PageController();
  int _currentPage = 0;
  String dateOfBirth = "";

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
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: controller,
              children: [
                BasicInfo(
                  goToNext: _goToNextPage,
                  pageController: controller,
                  onDateOfBirthChanged: (value) => dateOfBirth = value,
                ),
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
        dotColor: const Color(0xffF2DB8F),
        activeDotColor: const Color(0xffD3AF37),
      ),
    );
  }
}
