import '../ride_preferences_repository.dart';
import '../../model/ride/ride.dart';
import '../../model/ride_pref/ride_pref.dart';
import '../../service/ride_filter.dart';
import '../../model/user/user.dart';
import '../../model/ride/locations.dart';
import '../../model/ride/ride_sort_type.dart'; // Import the new enum

class MockRidesRepository implements RidesRepository {
  @override
  List<Ride> getRides(RidePref preference, RidesFilter? filter, RideSortType? sortType) {
    // Define mock rides
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
          firstName: 'Mengtech',
          lastName: 'Lee',
          email: 'mengtech@example.com',
          phone: '987-654-3210',
          profilePicture: 'path/to/profile.jpg',
          verifiedProfile: true,
          acceptsPets: true,
        ),
        availableSeats: 0, // This ride is full
        pricePerSeat: 10.0,
      ),
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
      Ride(
        departureLocation: Location(
          name: 'Phnom Penh',
          country: Country.cambodia,
        ),
        departureDate: DateTime.now(),
        arrivalLocation: Location(
          name: 'Siem Reap',
          country: Country.cambodia,
        ),
        arrivalDateTime: DateTime.now().add(Duration(hours: 3)),
        driver: User(
          firstName: 'Sokha',
          lastName: 'Ngin',
          email: 'sokha@example.com',
          phone: '456-789-0123',
          profilePicture: 'path/to/profile.jpg',
          verifiedProfile: true,
          acceptsPets: false, // Does not accept pets
        ),
        availableSeats: 3,
        pricePerSeat: 15.0,
      ),
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
          firstName: 'Vannak',
          lastName: 'Chhay',
          email: 'vannak@example.com',
          phone: '321-654-9870',
          profilePicture: 'path/to/profile.jpg',
          verifiedProfile: true,
          acceptsPets: true, // Accepts pets
        ),
        availableSeats: 4,
        pricePerSeat: 12.0,
      ),
      // Add more rides as needed to meet the test requirements
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
    void updateRidePreferences(RidePref newPref) {
    // Logic to update the ride preferences
    // This is a mock implementation, so you might just print or store it in memory
    print('Updated Ride Preferences: $newPref');
    // You can add logic to actually update the stored preferences
  }
}
