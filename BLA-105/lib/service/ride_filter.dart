// lib/service/rides_filter.dart

class RidesFilter {


  final bool petsAccepted;
  final double? maxPrice; // Maximum price per seat
  final int? minSeats;     // Minimum available seats

  RidesFilter({
    this.petsAccepted = false, // Default to false for pets accepted
    this.maxPrice,             // Optional
    this.minSeats,             // Optional
  });

}
