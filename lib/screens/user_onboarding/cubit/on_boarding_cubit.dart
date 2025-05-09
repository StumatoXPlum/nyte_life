import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingState());

  void setName(String name) {
    emit(state.copyWith(name: name));
  }

  void togglePreference(String preference) {
    final updatedPreferences = Set<String>.from(state.selectedPreferences);
    if (updatedPreferences.contains(preference)) {
      updatedPreferences.remove(preference);
    } else {
      updatedPreferences.add(preference);
    }
    emit(state.copyWith(selectedPreferences: updatedPreferences));
  }

  void setDrinkingPreference(String preference) {
    emit(state.copyWith(drinkingPreference: preference));
  }

  void setSmokingPreference(String preference) {
    emit(state.copyWith(smokingPreference: preference));
  }

  void setOutdoorSettingPrefrence(String preference) {
    emit(state.copyWith(outdoorSetting: preference));
  }

  String? getSelectedFoodOption(String category) {
    return state.selectedFoodPreferences[category];
  }

  void selectFoodPreference(String category, String option) {
    final current = Map<String, String>.from(state.selectedFoodPreferences);
    current[category] = option;
    emit(state.copyWith(selectedFoodPreferences: current));
  }

  bool isFoodPreferenceSelected(String category, String option) {
    return state.selectedFoodPreferences[category] == option;
  }
}

class OnboardingState {
  final String name;
  final Set<String> selectedPreferences;
  final String? drinkingPreference;
  final String? smokingPreference;
  final String? outdoorSetting;

  final Map<String, String> selectedFoodPreferences;

  OnboardingState({
    this.name = '',
    Set<String>? selectedPreferences,
    this.drinkingPreference,
    this.smokingPreference,
    this.outdoorSetting,
    Map<String, String>? selectedFoodPreferences,
  }) : selectedPreferences = selectedPreferences ?? {},
       selectedFoodPreferences = selectedFoodPreferences ?? {};

  OnboardingState copyWith({
    String? name,
    Set<String>? selectedPreferences,
    String? drinkingPreference,
    String? smokingPreference,
    String? outdoorSetting,
    Map<String, String>? selectedFoodPreferences,
  }) {
    return OnboardingState(
      name: name ?? this.name,
      selectedPreferences: selectedPreferences ?? this.selectedPreferences,
      drinkingPreference: drinkingPreference ?? this.drinkingPreference,
      smokingPreference: smokingPreference ?? this.smokingPreference,
      outdoorSetting: outdoorSetting ?? this.outdoorSetting,
      selectedFoodPreferences:
          selectedFoodPreferences ?? this.selectedFoodPreferences,
    );
  }
}
