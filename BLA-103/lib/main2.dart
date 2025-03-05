// lib/main.dart

import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/service/locations_service.dart';
import 'package:week_3_blabla_project/repository/mock/mock_locations_repository.dart';
import 'package:week_3_blabla_project/widgets/location_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locationsService = LocationsService(MockLocationsRepository());

    return MaterialApp(
      title: 'Location Picker',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Location Picker Example'),
        ),
        body: Center(
          child: LocationPicker(locationsService: locationsService),
        ),
      ),
    );
  }
}
