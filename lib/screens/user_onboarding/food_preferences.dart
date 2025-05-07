import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/custom_back_button.dart';
import '../../core/custom_continue.dart';
import 'cubit/on_boarding_cubit.dart';
import 'page_view_screen.dart';

class FoodPreferences extends StatefulWidget {
  final VoidCallback goToNext;
  final VoidCallback goToPrevious;
  final PageController pageController;
  const FoodPreferences({
    super.key,
    required this.goToNext,
    required this.goToPrevious,
    required this.pageController,
  });

  @override
  State<FoodPreferences> createState() => _FoodPreferencesState();
}

class _FoodPreferencesState extends State<FoodPreferences> {
  final Set<String> selectedOptions = {};

  final List<String> foodPaletteOptions = [
    'Spice in Food',
    'Salt in Food',
    'Dietary Preference',
  ];

  final List<String> cuisineOptions = [
    'Chinese',
    'Indian',
    'Pan-Asian',
    'Mexican',
    'Sea Food',
    'European',
    'Vietnamese',
    'Fine Dining',
  ];

  void toggleSelection(String option) {
    context.read<OnboardingCubit>().togglePreference(option);
  }

  bool isSelected(String option) {
    return context.watch<OnboardingCubit>().state.selectedPreferences.contains(
      option,
    );
  }

  Widget buildOption(String option) {
    final selected = isSelected(option);
    return GestureDetector(
      onTap: () => toggleSelection(option),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Text(
          option,
          style: TextStyle(
            color: selected ? Colors.black : Colors.black45,
            fontSize: 48.sp,
            fontFamily: 'britti',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomBackButton(onTap: widget.goToPrevious),
          SizedBox(height: 150.h),
          Center(
            child: CustomPageIndicator(
              controller: widget.pageController,
              pageCount: 3,
            ),
          ),
          SizedBox(height: 80.h),
          Align(
            alignment: Alignment.center,
            child: Text(
              "Please tell us a but about your \nFood Preferences",
              style: TextStyle(
                fontSize: 64.sp,
                fontFamily: 'britti',
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 80.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 99.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "How would you describe your Food Palette?",
                  style: TextStyle(
                    color: Color(0xffD3AF37),
                    fontSize: 48.sp,
                    fontFamily: 'britti',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 50.h),
                ...foodPaletteOptions.map(buildOption),
                SizedBox(height: 80.h),
                Text(
                  "What best cuisine is your favorite?",
                  style: TextStyle(
                    color: Color(0xffD3AF37),
                    fontSize: 48.sp,
                    fontFamily: 'britti',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 50.h),
                ...cuisineOptions.map(buildOption),
              ],
            ),
          ),
          Spacer(),
          Align(
            alignment: Alignment.center,
            child: CustomContinue(onTap: widget.goToNext),
          ),
          SizedBox(height: 153.h),
        ],
      ),
    );
  }
}
