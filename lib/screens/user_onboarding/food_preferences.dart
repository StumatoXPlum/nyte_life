import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
  final SupabaseClient supabase = Supabase.instance.client;
  late List<Map<String, dynamic>> foodPreferencesData;
  late List<String> cuisineOptions;
  late Future<void> _fetchPreferencesFuture;

  @override
  void initState() {
    super.initState();
    _fetchPreferencesFuture = fetchFoodPreferences();
  }

  Future<void> fetchFoodPreferences() async {
    try {
      final data = await supabase
          .from('food_preferences')
          .select('category, option')
          .order('category');

      if (data.isNotEmpty) {
        foodPreferencesData = List<Map<String, dynamic>>.from(data);

        setState(() {
          foodPaletteOptions =
              _getFoodPaletteOptions(
                foodPreferencesData,
              ).cast<Map<String, List<String>>>();
          cuisineOptions = _getCuisineOptions(foodPreferencesData);
        });
      }
    } catch (error) {
      print('Error fetching food preferences: $error');
    }
  }

  List<Map<String, List<String>>> foodPaletteOptions = [];
  List<Map<String, List<String>>> _getFoodPaletteOptions(
    List<Map<String, dynamic>> data,
  ) {
    final options = <String, List<String>>{};
    for (var entry in data) {
      final category = entry['category'];
      final option = entry['option'];

      if (category == 'Cuisine') continue;

      if (!options.containsKey(category)) {
        options[category] = [];
      }
      options[category]?.add(option);
    }
    return options.entries.map((e) => {e.key: e.value}).toList();
  }

  List<String> _getCuisineOptions(List<Map<String, dynamic>> data) {
    return data
        .where((entry) => entry['category'] == 'Cuisine')
        .map((entry) => entry['option'] as String)
        .toList();
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
    if (cuisineOptions.contains(option)) {
      context.read<OnboardingCubit>().toggleCuisine(option);
    } else {
      context.read<OnboardingCubit>().togglePreference(option);
    }
  }

  bool isSelected(String option) {
    if (cuisineOptions.contains(option)) {
      return context.watch<OnboardingCubit>().state.selectedCuisines.contains(
        option,
      );
    } else {
      return context
          .watch<OnboardingCubit>()
          .state
          .selectedPreferences
          .contains(option);
    }
  }

  Widget buildFoodPaletteSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          foodPaletteOptions.map((entry) {
            final category = entry.keys.first;
            final options = entry[category]!;
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

  void savePreferences() async {
    final foodPreferences =
        context.read<OnboardingCubit>().state.selectedFoodPreferences;
    final cuisines =
        context.read<OnboardingCubit>().state.selectedCuisines.toList();

    final user = supabase.auth.currentUser;
    if (user != null) {
      final preferences = {
        'food_preferences': foodPreferences,
        'cuisines': cuisines,
      };

      try {
        await supabase.from('users').upsert({
          'id': user.id,
          'preferences': preferences,
        });

        print('Food preferences saved successfully');
      } catch (error) {
        print('Error saving preferences: $error');
      }
    } else {
      print('User is not authenticated.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: _fetchPreferencesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return SingleChildScrollView(
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
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 60.w,
                    ),
                    child: Text(
                      "Please tell us a bit about your Food Preferences",
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
                        "What is your favorite cuisine?",
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
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 50.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomContinue(
              onTap: () {
                savePreferences();
                widget.goToNext();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FoodCategoryLabel extends StatelessWidget {
  final String label;
  const FoodCategoryLabel({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: Colors.black,
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
    super.key,
  });

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
