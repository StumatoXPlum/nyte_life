import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/custom_back_button.dart';
import '../../core/custom_continue.dart';
import 'bubble_screen.dart';
import 'cubit/on_boarding_cubit.dart';
import 'page_view_screen.dart';

class DrinkingPreferences extends StatefulWidget {
  final VoidCallback goToPrevious;
  final PageController pageController;
  const DrinkingPreferences({
    super.key,
    required this.goToPrevious,
    required this.pageController,
  });

  @override
  State<DrinkingPreferences> createState() => _DrinkingPreferencesState();
}

class _DrinkingPreferencesState extends State<DrinkingPreferences> {
  String? selectedDrinking;
  String? selectedSmoking;
  final List<String> drinkingOptions = ['Yes, I drink', 'No, I don\'t drink'];
  final List<String> smokingOptions = ['Yes, I smoke', 'No, I don\'t smoke'];

  void toggleDrinkingSelection(String option) {
    context.read<OnboardingCubit>().setDrinkingPreference(option);
    setState(() {
      selectedDrinking = option;
    });
  }

  void toggleSmokingSelection(String option) {
    context.read<OnboardingCubit>().setSmokingPreference(option);
    setState(() {
      selectedSmoking = option;
    });
  }

  Widget buildOption(
    String option,
    String? selectedOption,
    Function(String) onTap,
  ) {
    final isSelected = selectedOption == option;
    return GestureDetector(
      onTap: () => onTap(option),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Text(
          option,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.black45,
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
              "Please tell us a bit about your \nDrinking Preferences",
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
                  "Are you a drinker?",
                  style: TextStyle(
                    color: Color(0xffD3AF37),
                    fontSize: 48.sp,
                    fontFamily: 'britti',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 50.h),
                ...drinkingOptions.map(
                  (option) => buildOption(
                    option,
                    selectedDrinking,
                    toggleDrinkingSelection,
                  ),
                ),
                SizedBox(height: 80.h),
                Text(
                  "Are you a Smoker?",
                  style: TextStyle(
                    color: Color(0xffD3AF37),
                    fontSize: 48.sp,
                    fontFamily: 'britti',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 50.h),
                ...smokingOptions.map(
                  (option) => buildOption(
                    option,
                    selectedSmoking,
                    toggleSmokingSelection,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Align(
            alignment: Alignment.center,
            child: CustomContinue(
              onTap: () {
                final state = context.read<OnboardingCubit>().state;
                final combinedPreferences = [
                  if (state.name.isNotEmpty) state.name,
                  ...state.selectedPreferences,
                  if (state.drinkingPreference != null)
                    state.drinkingPreference!,
                  if (state.smokingPreference != null) state.smokingPreference!,
                ];

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => BubbleScreen(
                          preferences: combinedPreferences,
                          name: state.name,
                        ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 153.h),
        ],
      ),
    );
  }
}
