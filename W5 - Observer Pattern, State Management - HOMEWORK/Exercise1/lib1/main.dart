import 'service/ride_preference_service.dart';
import 'model/ride_preferences/console_logger.dart';
import 'model/ride_preferences/ride_preference.dart';

void main() {
  final service = RidePreferencesService();
  final logger = ConsoleLogger();

  service.addListener(logger);

  // Change preferences and observe the console output
  service.setSelectedPreference(RidePreference.economy);
  service.setSelectedPreference(RidePreference.premium);
  service.setSelectedPreference(RidePreference.luxury);
}
