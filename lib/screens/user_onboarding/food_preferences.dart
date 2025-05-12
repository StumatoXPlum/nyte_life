import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            fontSize: 14.sp,
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
                  Expanded(
                    flex: 3,
                    child: Text(
                      category,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: buildTogglePill(
                      category: category,
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
            fontSize: 18.sp,
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
            Align(
              alignment: Alignment.center,
              child: Text(
                "Please tell us a but about your \nFood Preferences",
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
                  Text(
                    "How would you describe your Food Palette?",
                    style: TextStyle(
                      color: Color(0xffD3AF37),
                      fontSize: 18.sp,
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
                      fontSize: 18.sp,
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
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(30.r),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children:
          options.map((option) {
            final isSelected = selectedOption == option;
            return Expanded(
              child: GestureDetector(
                onTap: () => onSelect(option),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  decoration: BoxDecoration(
                    color: isSelected ? Color(0xffD3AF37) : Colors.transparent,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    option,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
    ),
  );
}
