import 'package:flutter/material.dart';
import '../model/ride/ride_pref.dart';
import '../repository/ride_preferences_repository.dart';
import 'async_value.dart';

class RidesPreferencesProvider with ChangeNotifier {
  final RidePreferencesRepository repository;
  RidePreference? _currentPreference;
   late AsyncValue<List<RidePreference>> pastPreferences;

  // Constructor to load past preferences
  RidesPreferencesProvider(this.repository) {
    fetchPastPreferences(); 
  }

  // Getter for current preference
  RidePreference? get currentPreference => _currentPreference;

  // Getter for past preferences (newest to oldest)
  AsyncValue<List<RidePreference>> get preferencesHistory => pastPreferences;

  // Private method to load past preferences from the repository
    Future<void> fetchPastPreferences() async {
    // 1. Handle loading
    pastPreferences = AsyncValue.loading();
    notifyListeners();

    try {
      // 2. Fetch data
      List<RidePreference> pastPrefs = await repository.getPastPreferences();
      // 3. Handle success
      pastPreferences = AsyncValue.data(pastPrefs);
    } catch (error) {
      // 4. Handle error
      pastPreferences = AsyncValue.error(error.toString());
    }
    notifyListeners();
  }

  // Method to set the current preference
  void setCurrentPreference(RidePreference newPreference) {
    // Process only if the new preference is not equal to the current one
    if (_currentPreference != null && _currentPreference == newPreference) {
      return; // No change needed
    }

    // Update the current preference
    _currentPreference = newPreference;

    // Update the history if the new preference is different
    if (!pastPreferences.value!.contains(newPreference)) {
      pastPreferences.value!.add(newPreference);
    }

    // Notify listeners of the change
    notifyListeners();
  }

  Future<void> addPreference(RidePreference preference) async {
    try {
      // First approach:
      // 1. Call the repository addPreference
      await repository.addPreference(preference);
      // 2. Fetch again the data from the repository
      await fetchPastPreferences();

      // Alternatively, you can use the second approach as discussed below.
      // Uncomment the following lines if you prefer the second approach:
      /*
      await repository.addPreference(preference);
      pastPreferences.data!.add(preference); // Update the cache directly
      */
    } catch (error) {
      // Handle error if adding preference fails
      pastPreferences = AsyncValue.error(error.toString());
      notifyListeners();
    }
  }
}
