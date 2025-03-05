// lib/repository/mock/mock_rides_repository.dart

import '../ride_preferences_repository.dart';
import '../../model/ride/ride.dart';
import '../../model/ride_pref/ride_pref.dart';
import '../../service/ride_filter.dart';
import '../../model/user/user.dart';
import '../../model/ride/locations.dart';
import '../../model/ride/ride_sort_type.dart'; // Import the new enum
import '../../dummy_data/dummy_data.dart';

class MockRidesRepository implements RidesRepository {
  @override
  List<Ride> getRides(RidePref preference, RidesFilter? filter, RideSortType? sortType) {
    List<Ride> rides = [
      Ride(
        departureLocation: Location(
          name: 'Battambang',
          country: Country.cambodia,
        ),
        departureDate: DateTime.now(),
        arrivalLocation: Location(
          name: 'Siem Reap',
          country: Country.cambodia,
        ),
        arrivalDateTime: DateTime.now().add(Duration(hours: 2)),
        driver: User(
          firstName: 'John',
          lastName: 'Doe',
          email: 'john@example.com',
          phone: '123-456-7890',
          profilePicture: 'path/to/profile.jpg',
          verifiedProfile: true,
          acceptsPets: true,
        ),
        availableSeats: 2,
        pricePerSeat: 10.0,
      ),
      // Add more rides as needed
    ];

    // Filter rides based on the RidesFilter
    if (filter != null) {
      if (filter.petsAccepted) {
        rides = rides.where((ride) => ride.driver.acceptsPets).toList();
      }
      if (filter.maxPrice != null) {
        rides = rides.where((ride) => ride.pricePerSeat <= filter.maxPrice!).toList();
      }
      if (filter.minSeats != null) {
        rides = rides.where((ride) => ride.availableSeats >= filter.minSeats!).toList();
      }
    }

    // Sort rides based on the RideSortType
    if (sortType != null) {
      switch (sortType) {
        case RideSortType.departureTime:
          rides.sort((a, b) => a.departureDate.compareTo(b.departureDate));
          break;
        case RideSortType.arrivalTime:
          rides.sort((a, b) => a.arrivalDateTime.compareTo(b.arrivalDateTime));
          break;
        case RideSortType.price:
          rides.sort((a, b) => a.pricePerSeat.compareTo(b.pricePerSeat));
          break;
      }
    }

    return rides;
  }
}
