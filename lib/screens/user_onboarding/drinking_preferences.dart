import 'package:flutter/material.dart';
import 'package:nytelife/core/custom_back_button.dart';
import 'package:nytelife/core/custom_continue.dart';
import 'package:nytelife/screens/user_onboarding/bubble_screen.dart';
import 'package:nytelife/screens/user_onboarding/page_view_screen.dart';

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
  final List<String> drinkingOptions = ['Yes', 'No'];
  final List<String> smokingOptions = ['Yes', 'No'];

  void toggleDrinkingSelection(String option) {
    setState(() {
      selectedDrinking = option;
    });
  }

  void toggleSmokingSelection(String option) {
    setState(() {
      selectedSmoking = option;
    });
  }

  Widget buildOption(
    String option,
    String? selectedOption,
    Function(String) onTap,
  ) {
    final Size size = MediaQuery.of(context).size;
    double padding = size.width * 0.05;
    double fontSize = size.width * 0.045;
    final isSelected = selectedOption == option;
    return GestureDetector(
      onTap: () => onTap(option),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: padding * 0.15),
        child: Text(
          option,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.black45,
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
        padding: EdgeInsets.symmetric(horizontal: padding * 2),
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
                "Please tell us a bit about your \nDrinking Preferences",
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
              "Are you a drinker?",
              style: TextStyle(
                color: Color(0xffD3AF37),
                fontSize: fontSize,
                fontFamily: 'britti',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            ...drinkingOptions.map(
              (option) => buildOption(
                option,
                selectedDrinking,
                toggleDrinkingSelection,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              "Are you a Smoker?",
              style: TextStyle(
                color: Color(0xffD3AF37),
                fontSize: fontSize,
                fontFamily: 'britti',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            ...smokingOptions.map(
              (option) =>
                  buildOption(option, selectedSmoking, toggleSmokingSelection),
            ),
            Spacer(),
            Align(
              alignment: Alignment.center,
              child: CustomContinue(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BubbleScreen()),
                  );
                },
              ),
            ),
            SizedBox(height: size.height * 0.05),
          ],
        ),
      ),
    );
  }
}
