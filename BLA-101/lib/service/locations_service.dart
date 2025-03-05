// lib/service/locations_service.dart

import '../repository/locations_repository.dart';
import '../repository/mock/mock_locations_repository.dart';
import '../model/ride/locations.dart';

class LocationsService {
  static final LocationsRepository _repository = MockLocationsRepository();

  static List<Location> get availableLocations {
    return _repository.getLocations();
  }
}
