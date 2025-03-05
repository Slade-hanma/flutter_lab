// lib/repository/ride_preferences_repository.dart

import '../../model/ride/ride.dart';
import '../../model/ride_pref/ride_pref.dart';
import '../../service/ride_filter.dart';
import '../../model/ride/ride_sort_type.dart'; // Import the RideSortType

abstract class RidesRepository {
  // Updated method signature to include sortType
  List<Ride> getRides(RidePref preference, RidesFilter? filter, RideSortType? sortType);
}
