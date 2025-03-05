// lib/repository/rides_repository.dart

import '../model/ride/ride.dart';
import '../model/ride_pref/ride_pref.dart';
import '../service/ride_filter.dart';

abstract class RidesRepository {
  List<Ride> getRides(RidePref preference, RidesFilter? filter);
}
