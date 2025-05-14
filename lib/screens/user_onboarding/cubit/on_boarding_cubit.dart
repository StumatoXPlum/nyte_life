import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingState());

  void setName(String name) => emit(state.copyWith(name: name));

  void togglePreference(String preference) {
    final updatedPreferences = Set<String>.from(state.selectedPreferences);
    updatedPreferences.contains(preference)
        ? updatedPreferences.remove(preference)
        : updatedPreferences.add(preference);
    emit(state.copyWith(selectedPreferences: updatedPreferences));
  }

  void setDrinkingPreference(String preference) =>
      emit(state.copyWith(drinkingPreference: preference));

  void setSmokingPreference(String preference) =>
      emit(state.copyWith(smokingPreference: preference));

  void setOutdoorSettingPreference(String preference) =>
      emit(state.copyWith(outdoorSetting: preference));

  void selectFoodPreference(String category, String option) {
    final current = Map<String, String>.from(state.selectedFoodPreferences);
    current[category] = option;
    emit(state.copyWith(selectedFoodPreferences: current));
  }

  String? getSelectedFoodOption(String category) =>
      state.selectedFoodPreferences[category];

  bool isFoodPreferenceSelected(String category, String option) =>
      state.selectedFoodPreferences[category] == option;

  void toggleCuisine(String cuisine) {
    final updated = Set<String>.from(state.selectedCuisines);
    if (updated.contains(cuisine)) {
      updated.remove(cuisine);
    } else {
      updated.add(cuisine);
    }
    emit(state.copyWith(selectedCuisines: updated));
  }

  void setGender(String gender) => emit(state.copyWith(gender: gender));

  void setDateOfBirth(String dob) => emit(state.copyWith(dateOfBirth: dob));

  void setAddress(String address) => emit(state.copyWith(address: address));

  void setFoodPreferences(Map<String, String> foodPreferences) {
    emit(state.copyWith(selectedFoodPreferences: foodPreferences));
  }
}

class OnboardingState {
  final String name;
  final Set<String> selectedPreferences;
  final String? drinkingPreference;
  final String? smokingPreference;
  final String? outdoorSetting;
  final Map<String, String> selectedFoodPreferences;
  final String? gender;
  final String? dateOfBirth;
  final String? address;
  final Set<String> selectedCuisines; 

  OnboardingState({
    this.name = '',
    Set<String>? selectedPreferences,
    this.drinkingPreference,
    this.smokingPreference,
    this.outdoorSetting,
    Map<String, String>? selectedFoodPreferences,
    this.gender,
    this.dateOfBirth,
    this.address,
    Set<String>? selectedCuisines, 
  }) : selectedPreferences = selectedPreferences ?? {},
       selectedFoodPreferences = selectedFoodPreferences ?? {},
       selectedCuisines = selectedCuisines ?? {}; 

  OnboardingState copyWith({
    String? name,
    Set<String>? selectedPreferences,
    String? drinkingPreference,
    String? smokingPreference,
    String? outdoorSetting,
    Map<String, String>? selectedFoodPreferences,
    String? gender,
    String? dateOfBirth,
    String? address,
    Set<String>? selectedCuisines, 
  }) {
    return OnboardingState(
      name: name ?? this.name,
      selectedPreferences: selectedPreferences ?? this.selectedPreferences,
      drinkingPreference: drinkingPreference ?? this.drinkingPreference,
      smokingPreference: smokingPreference ?? this.smokingPreference,
      outdoorSetting: outdoorSetting ?? this.outdoorSetting,
      selectedFoodPreferences:
          selectedFoodPreferences ?? this.selectedFoodPreferences,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      address: address ?? this.address,
      selectedCuisines:
          selectedCuisines ?? this.selectedCuisines,
    );
  }
}
