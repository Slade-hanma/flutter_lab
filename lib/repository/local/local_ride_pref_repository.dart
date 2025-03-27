import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/ride/ride_pref.dart';
import '../../dummy_data/dto/ride_preference_dto.dart';
import '../ride_preferences_repository.dart';

class LocalRidePreferencesRepository extends RidePreferencesRepository {
  static const String _preferencesKey = "ride_preferences";

  @override
  Future<List<RidePreference>> getPastPreferences() async {
    // Get SharedPreferences instance
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Get the string list from the key
    final List<String>? prefsList = prefs.getStringList(_preferencesKey);

    
    // Convert the string list to a list of RidePreferences
    return prefsList?.map((json) => RidePreference.fromJson(jsonDecode(json))).toList() ?? [];
  }

  @override
  Future<void> addPreference(RidePreference preference) async {
    // Call getPastPreferences
    final List<RidePreference> preferences = await getPastPreferences();
    
    // Add the new preference
    preferences.add(preference);

    // Save the new list as a string list
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _preferencesKey,
      preferences.map((pref) => jsonEncode(RidePreferenceDto.toJson(pref))).toList(),
    );
  }
}
