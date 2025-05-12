import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nytelife/core/custom_widgets/custom_bottom_bar.dart';
import '../../core/custom_widgets/custom_back_button.dart';
import '../../core/custom_widgets/custom_continue.dart';
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
  String? drinkingAnswer;
  String? smokingAnswer;
  Set<String> selectedOutdoorSettings = {};

  final List<String> outdoorSetting = [
    'Outdoor',
    'Indoor',
    'Open Spaces',
    'Rooftop',
  ];

  void toggleOutdoorSettingSelection(String option) {
    setState(() {
      if (selectedOutdoorSettings.contains(option)) {
        selectedOutdoorSettings.remove(option);
      } else {
        selectedOutdoorSettings.add(option);
      }
    });
  }

  Widget buildYesNoOption(
    String question,
    String? currentAnswer,
    Function(String) onSelect,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              question,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
                fontFamily: 'britti',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children:
                ['Yes', 'No'].map((option) {
                  final isSelected = currentAnswer == option;
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: GestureDetector(
                      onTap: () => onSelect(option),
                      child: Text(
                        option,
                        style: TextStyle(
                          color:
                              isSelected ? Color(0xffD3AF37) : Colors.black26,
                          fontSize: 20.sp,
                          fontFamily: 'britti',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  Widget buildOutdoorOption(
    String option,
    Set<String> selectedOptions,
    Function(String) onTap,
  ) {
    final isSelected = selectedOptions.contains(option);
    return GestureDetector(
      onTap: () => onTap(option),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Text(
          option,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.black45,
            fontSize: 18.sp,
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
          SizedBox(height: 50.h),
          Center(
            child: CustomPageIndicator(
              controller: widget.pageController,
              pageCount: 3,
            ),
          ),
          SizedBox(height: 22.h),
          Align(
            alignment: Alignment.center,
            child: Text(
              "Please tell us a bit about your \nDrinking Preferences",
              style: TextStyle(
                fontSize: 26.sp,
                fontFamily: 'britti',
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildYesNoOption("Are you a drinker?", drinkingAnswer, (
                  answer,
                ) {
                  context.read<OnboardingCubit>().setDrinkingPreference(answer);
                  setState(() {
                    drinkingAnswer = answer;
                  });
                }),
                buildYesNoOption("Are you a smoker?", smokingAnswer, (answer) {
                  context.read<OnboardingCubit>().setSmokingPreference(answer);
                  setState(() {
                    smokingAnswer = answer;
                  });
                }),
                SizedBox(height: 40.h),
                Text(
                  "Can you describe your ideal outdoor setting?",
                  style: TextStyle(
                    color: Color(0xffD3AF37),
                    fontSize: 18.sp,
                    fontFamily: 'britti',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.h),
                ...outdoorSetting.map(
                  (option) => buildOutdoorOption(
                    option,
                    selectedOutdoorSettings,
                    toggleOutdoorSettingSelection,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 50.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomContinue(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CustomBottomBar()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
