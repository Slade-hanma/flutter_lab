import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/ride/ride_filter.dart';
import '../../../model/ride/ride.dart';
import '../../../model/ride/ride_pref.dart';
import '../../../provider/rides_pref_provider.dart'; // Ensure this import is correct
import '../../../service/rides_service.dart';
import '../../theme/theme.dart';
import '../../../utils/animations_util.dart';
import 'widgets/ride_pref_bar.dart';
import 'widgets/ride_pref_modal.dart';
import 'widgets/rides_tile.dart';

///
/// The Ride Selection screen allows the user to select a ride, once ride preferences have been defined.
/// The screen also allows the user to redefine the ride preferences and to activate some filters.
///
class RidesScreen extends StatelessWidget {
  const RidesScreen({super.key});

  RidePreference getCurrentPreference(BuildContext context) {
    return Provider.of<RidesPreferencesProvider>(context, listen: false).currentPreference!;
  }

  List<Ride> getMatchingRides(BuildContext context, RideFilter currentFilter) {
    return RidesService.instance.getRidesFor(getCurrentPreference(context), currentFilter);
  }

  void onBackPressed(BuildContext context) {
    // 1 - Back to the previous view
    Navigator.of(context).pop();
  }

  Future<void> onRidePrefSelected(BuildContext context, RidePreference newPreference) async {
    final ridesPreferencesProvider = Provider.of<RidesPreferencesProvider>(context, listen: false);
    
    // Update the current preference
    ridesPreferencesProvider.setCurrentPreference(newPreference);
  }

  Future<void> onPreferencePressed(BuildContext context) async {
    // Open a modal to edit the ride preferences
    RidePreference? newPreference = await Navigator.of(context).push<RidePreference>(
      AnimationUtils.createTopToBottomRoute(
        RidePrefModal(initialPreference: getCurrentPreference(context)),
      ),
    );

    if (newPreference != null) {
      await onRidePrefSelected(context, newPreference);
    }
  }

  void onFilterPressed() {
    // Implement filter functionality here
  }

  @override
  Widget build(BuildContext context) {
    RideFilter currentFilter = RideFilter(); // Initialize or get from provider if needed
    List<Ride> matchingRides = getMatchingRides(context, currentFilter);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: BlaSpacings.m,
          right: BlaSpacings.m,
          top: BlaSpacings.s,
        ),
        child: Column(
          children: [
            // Top search Search bar
            RidePrefBar(
              ridePreference: getCurrentPreference(context),
              onBackPressed: () => onBackPressed(context),
              onPreferencePressed: () => onPreferencePressed(context),
              onFilterPressed: onFilterPressed,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: matchingRides.length,
                itemBuilder: (ctx, index) => RideTile(
                  ride: matchingRides[index],
                  onPressed: () {}, // Implement ride selection logic here
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
