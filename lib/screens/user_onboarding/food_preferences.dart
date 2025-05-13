// screens/user_onboarding/food_preferences.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import '../../core/custom_widgets/custom_back_button.dart';
import '../../core/custom_widgets/custom_continue.dart';
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

  final Map<String, List<String>> foodPaletteOptions = {
    'Spice in Food': ['Low', 'Medium', 'High'],
    'Salt in Food': ['Low', 'Medium', 'High'],
    'Dietary Preference': ['Veg', 'Non-Veg', 'Vegan'],
  };

  Widget buildPillOption(String category, String option) {
    final selected = context.read<OnboardingCubit>().isFoodPreferenceSelected(
      category,
      option,
    );

    return GestureDetector(
      onTap:
          () => context.read<OnboardingCubit>().selectFoodPreference(
            category,
            option,
          ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: selected ? Colors.orange : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Text(
          option,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget buildFoodPaletteSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          foodPaletteOptions.entries.map((entry) {
            final category = entry.key;
            final options = entry.value;
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(flex: 3, child: FoodCategoryLabel(label: category)),
                  Expanded(
                    flex: 7,
                    child: FoodOptionsSegment(
                      options: options,
                      selectedOption: context
                          .watch<OnboardingCubit>()
                          .getSelectedFoodOption(category),
                      onSelect: (selected) {
                        context.read<OnboardingCubit>().selectFoodPreference(
                          category,
                          selected,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }

  Widget buildOption(String option) {
    final selected = isSelected(option);
    return GestureDetector(
      onTap: () => toggleSelection(option),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        child: Text(
          option,
          style: TextStyle(
            color: selected ? Colors.black : Colors.black45,
            fontSize: 14.sp,
            fontFamily: 'britti',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void toggleSelection(String option) {
    context.read<OnboardingCubit>().togglePreference(option);
  }

  bool isSelected(String option) {
    return context.watch<OnboardingCubit>().state.selectedPreferences.contains(
      option,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: size.width - 60.w),
                child: Text(
                  "Please tell us a but about your Food Preferences",
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontFamily: 'britti',
                    fontWeight: FontWeight.bold,
                    height: 1.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "How would you describe your Food Palette?",
                    style: TextStyle(
                      color: Color(0xffD3AF37),
                      fontSize: 14.sp,
                      fontFamily: 'britti',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  buildFoodPaletteSection(),
                  SizedBox(height: 20.h),
                  Text(
                    "What best cuisine is your favorite?",
                    style: TextStyle(
                      color: Color(0xffD3AF37),
                      fontSize: 14.sp,
                      fontFamily: 'britti',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  ...cuisineOptions.map(buildOption),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 50.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [CustomContinue(onTap: widget.goToNext)],
        ),
      ),
    );
  }
}

Widget buildTogglePill({
  required String category,
  required List<String> options,
  required String? selectedOption,
  required Function(String) onSelect,
}) {
  return CupertinoSegmentedControl<String>(
    children: {
      for (var option in options)
        option: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Text(
            option,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: selectedOption == option ? Colors.white : Colors.black,
            ),
          ),
        ),
    },
    groupValue: selectedOption,
    onValueChanged: (val) => onSelect(val),
    selectedColor: const Color(0xffD3AF37),
    unselectedColor: CupertinoColors.systemGrey5,
    borderColor: CupertinoColors.systemGrey3,
    pressedColor: CupertinoColors.systemGrey4,
    padding: EdgeInsets.zero,
  );
}

class FoodCategoryLabel extends StatelessWidget {
  final String label;
  const FoodCategoryLabel({required this.label, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: Colors.black87,
        fontSize: 12.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class FoodOptionsSegment extends StatelessWidget {
  final List<String> options;
  final String? selectedOption;
  final Function(String) onSelect;
  const FoodOptionsSegment({
    required this.options,
    required this.selectedOption,
    required this.onSelect,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoSegmentedControl<String>(
      children: {
        for (var option in options)
          option: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Text(
              option,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                color: selectedOption == option ? Colors.white : Colors.black,
              ),
            ),
          ),
      },
      groupValue: selectedOption,
      onValueChanged: (val) => onSelect(val),
      selectedColor: const Color(0xffD3AF37),
      unselectedColor: CupertinoColors.systemGrey5,
      borderColor: CupertinoColors.systemGrey3,
      pressedColor: CupertinoColors.systemGrey4,
      padding: EdgeInsets.zero,
    );
  }
}
