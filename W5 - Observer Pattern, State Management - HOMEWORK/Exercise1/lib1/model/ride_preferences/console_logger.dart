import 'ride_preferences_listener.dart';
import 'ride_preference.dart';

class ConsoleLogger implements RidePreferencesListener {
  @override
  void onPreferenceSelected(RidePreference selectedPreference) {
    print("Preference changed to: $selectedPreference");
  }
}
