import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nytelife/core/custom_back_button.dart';
import 'package:nytelife/core/custom_continue.dart';
import 'package:nytelife/screens/user_onboarding/cubit/on_boarding_cubit.dart';
import 'package:nytelife/screens/user_onboarding/page_view_screen.dart';

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
    final Size size = MediaQuery.of(context).size;
    double padding = size.width * 0.05;
    double fontSize = size.width * 0.045;
    final selected = isSelected(option);
    return GestureDetector(
      onTap: () => toggleSelection(option),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: padding * 0.15),
        child: Text(
          option,
          style: TextStyle(
            color: selected ? Colors.black : Colors.black45,
            fontSize: fontSize * 1.3,
            fontFamily: 'britti',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double padding = size.width * 0.05;
    double fontSize = size.width * 0.045;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding * 1.7),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomBackButton(onTap: widget.goToPrevious),
              SizedBox(height: size.height * 0.03),
              Center(
                child: CustomPageIndicator(
                  controller: widget.pageController,
                  pageCount: 3,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Please tell us a but about your \nFood Preferences",
                  style: TextStyle(
                    fontSize: fontSize * 1.4,
                    fontFamily: 'britti',
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                "How would you describe your Food Palette?",
                style: TextStyle(
                  color: Color(0xffD3AF37),
                  fontSize: fontSize,
                  fontFamily: 'britti',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              ...foodPaletteOptions.map(buildOption),
              SizedBox(height: size.height * 0.03),
              // question
              Text(
                "What best cuisine is your favorite?",
                style: TextStyle(
                  color: Color(0xffD3AF37),
                  fontSize: fontSize,
                  fontFamily: 'britti',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              ...cuisineOptions.map(buildOption),
              SizedBox(height: size.height * 0.08),
              Align(
                alignment: Alignment.center,
                child: CustomContinue(onTap: widget.goToNext),
              ),
              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
