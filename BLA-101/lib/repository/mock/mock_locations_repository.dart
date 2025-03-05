// lib/repository/mock/mock_locations_repository.dart

import '../locations_repository.dart';
import '../../model/ride/locations.dart';

class MockLocationsRepository implements LocationsRepository {
  @override
  List<Location> getLocations() {
    return [
      const Location(name: 'Phnom Penh', country: Country.cambodia),
      const Location(name: 'Siem Reap', country: Country.cambodia),
      const Location(name: 'Battambang', country: Country.cambodia),
      const Location(name: 'Sihanoukville', country: Country.cambodia),
      const Location(name: 'Kampot', country: Country.cambodia),
    ];
  }
}
