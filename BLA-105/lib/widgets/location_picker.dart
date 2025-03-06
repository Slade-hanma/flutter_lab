// lib/widgets/location_picker.dart

import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/service/locations_service.dart';
import '../model/ride/locations.dart';

class LocationPicker extends StatelessWidget {
  final LocationsService locationsService;

  LocationPicker({required this.locationsService});

  @override
  Widget build(BuildContext context) {
    final locations = locationsService.availableLocations;

    return DropdownButton<Location>(
      items: locations.map((Location location) {
        return DropdownMenuItem<Location>(
          value: location,
          child: Text(location.toString()),
        );
      }).toList(),
      onChanged: (Location? newValue) {
        // Handle location change
        print('Selected location: ${newValue?.name}');
      },
      hint: Text('Select a location'),
    );
  }
}
