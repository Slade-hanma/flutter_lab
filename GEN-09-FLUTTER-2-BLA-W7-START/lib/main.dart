import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'repository/mock/mock_locations_repository.dart';
import 'repository/mock/mock_rides_repository.dart';
import 'service/locations_service.dart';
import 'service/rides_service.dart';

import 'repository/mock/mock_ride_preferences_repository.dart';
import 'ui/screens/ride_pref/ride_pref_screen.dart';
import 'provider/rides_pref_provider.dart'; // Ensure this import is correct

void main() {
  // 1 - Initialize the services
  // RidePrefService.initialize(MockRidePreferencesRepository());
  LocationsService.initialize(MockLocationsRepository());
  RidesService.initialize(MockRidesRepository());

  // 2- Run the UI
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RidesPreferencesProvider(MockRidePreferencesRepository()),
        ),
        // Add other providers here as needed
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Scaffold(body: RidePrefScreen()),
      ),
    );
  }
}
