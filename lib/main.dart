// import 'package:flutter/material.dart';
// import 'screens/ride_pref/ride_pref_screen.dart';
// import 'theme/theme.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: appTheme,
//       home: Scaffold(body: RidePrefScreen()),
//     );
//   }
// }

import 'package:week_3_blabla_project/service/rides_service.dart';
import 'package:week_3_blabla_project/model/ride/ride.dart';

void main() {
  // Display the available rides
  print("Available Rides Today:");

  // Get today's date
  DateTime today = DateTime.now();
  DateTime startOfDay = DateTime(today.year, today.month, today.day);
  DateTime endOfDay = startOfDay.add(Duration(days: 1));

  // Filter rides based on today's date
  List<Ride> availableRidesToday = RidesService.availableRides.where((ride) =>
      ride.departureDate.isAfter(startOfDay) && ride.departureDate.isBefore(endOfDay)).toList();

  if (availableRidesToday.isEmpty) {
    print("No rides available today.");
  } else {
    for (var ride in availableRidesToday) {
      print(ride); // This will use the overridden toString method
    }
  }
}
