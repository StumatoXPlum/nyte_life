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
}

class OnboardingState {
  final String name;
  final Set<String> selectedPreferences;
  final String? drinkingPreference;
  final String? smokingPreference;

  OnboardingState({
    this.name = '',
    Set<String>? selectedPreferences,
    this.drinkingPreference,
    this.smokingPreference,
  }) : selectedPreferences = selectedPreferences ?? {};

  OnboardingState copyWith({
    String? name,
    Set<String>? selectedPreferences,
    String? drinkingPreference,
    String? smokingPreference,
  }) {
    return OnboardingState(
      name: name ?? this.name,
      selectedPreferences: selectedPreferences ?? this.selectedPreferences,
      drinkingPreference: drinkingPreference ?? this.drinkingPreference,
      smokingPreference: smokingPreference ?? this.smokingPreference,
    );
  }
}
