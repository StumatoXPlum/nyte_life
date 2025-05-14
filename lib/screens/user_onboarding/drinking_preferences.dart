import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nytelife/core/custom_widgets/custom_bottom_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/custom_widgets/custom_back_button.dart';
import '../../core/custom_widgets/custom_continue.dart';
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

  List<Map<String, dynamic>> questions = [];

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  Future<void> _fetchQuestions() async {
    try {
      print('Fetching questions from Supabase...');
      final response =
          await Supabase.instance.client.from('drinking_preferences').select();

      print('Response received: $response');

      setState(() {
        questions = List<Map<String, dynamic>>.from(response);
      });
      print('Questions loaded: ${questions.length}');
    } catch (e) {
      print('Exception while fetching questions: $e');
    }
  }

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

  Future<void> _savePreferences() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) {
      print("No user logged in.");
      return;
    }

    final preferences = {
      'drinking': drinkingAnswer,
      'smoking': smokingAnswer,
      'outdoor_settings': selectedOutdoorSettings.toList(),
    };

    try {
      final response = await Supabase.instance.client
          .from('users')
          .update({'preferences': preferences})
          .eq('id', userId);

      if (response.error != null) {
        print('Error saving preferences: ${response.error!.message}');
      } else {
        print('Preferences saved successfully');
      }
    } catch (e) {
      print('Exception saving preferences: $e');
    }
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
                "Please tell us a bit about your Drinking Preferences",
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
                  if (questions.isNotEmpty) ...[
                    for (Map<String, dynamic> questionData in questions) ...[
                      if (questionData['question_type'] == 'Text') ...[
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: Text(
                            questionData['question'] ?? '',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontFamily: 'britti',
                              fontWeight: FontWeight.bold,
                              color: Color(0xffD3AF37),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ] else if (questionData['question_type'] == 'Yes/No') ...[
                        buildYesNoOption(
                          questionData['question'] as String,
                          questionData['question'] == "Are you a drinker?"
                              ? drinkingAnswer
                              : smokingAnswer,
                          (answer) {
                            setState(() {
                              if (questionData['question'] ==
                                  "Are you a drinker?") {
                                drinkingAnswer = answer;
                              } else if (questionData['question'] ==
                                  "Are you a smoker?") {
                                smokingAnswer = answer;
                              }
                            });
                          },
                        ),
                      ] else if (questionData['question_type'] ==
                          'Multiple Choice') ...[
                        SizedBox(height: 20.h),
                        Text(
                          questionData['question'] as String,
                          style: TextStyle(
                            color: Color(0xffD3AF37),
                            fontSize: 18.sp,
                            fontFamily: 'britti',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        ...List<String>.from(questionData['options'] ?? []).map(
                          (option) => buildOutdoorOption(
                            option,
                            selectedOutdoorSettings,
                            toggleOutdoorSettingSelection,
                          ),
                        ),
                      ],
                    ],
                  ],
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
          children: [
            CustomContinue(
              onTap: () async {
                await _savePreferences();
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
