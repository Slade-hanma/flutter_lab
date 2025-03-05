// lib/service/rides_service.dart

import '../dummy_data/dummy_data.dart';
import '../model/ride/ride.dart';
import '../repository/rides_repository.dart';
import '../repository/mock/mock_rides_repository.dart';
import '../model/ride_pref/ride_pref.dart';
import 'rides_filter.dart';

class RidesService {
  static final RidesService _instance = RidesService._internal();
  static RidesRepository _repository = MockRidesRepository(); // Default repository

  factory RidesService() {
    return _instance;
  }

  RidesService._internal();

  // Initializer method to specify the repository
  void initialize(RidesRepository repository) {
    _repository = repository;
  }

  /// Return the relevant rides, given the passenger preferences and filter
  List<Ride> getRidesFor(RidePref preferences, RidesFilter? filter) {
    return _repository.getRides(preferences, filter);
  }
}
