import '../model/ride_preferences/ride_preferences_listener.dart';
import '../model/ride_preferences/ride_preference.dart';

class RidePreferencesService {
  final List<RidePreferencesListener> _listeners = [];
  RidePreference? _selectedPreference;

  void addListener(RidePreferencesListener listener) {
    _listeners.add(listener);
  }

  void notifyListeners() {
    for (var listener in _listeners) {
      listener.onPreferenceSelected(_selectedPreference!);
    }
  }

  void setSelectedPreference(RidePreference preference) {
    _selectedPreference = preference;
    notifyListeners();
  }
}
