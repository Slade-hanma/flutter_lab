import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_3_blabla_project/provider/async_value.dart';

import '../../../model/ride/ride_pref.dart';
import '../../../provider/rides_pref_provider.dart'; 
import '../../theme/theme.dart';

import '../../../utils/animations_util.dart';
import '../rides/rides_screen.dart';
import 'widgets/ride_pref_form.dart';
import 'widgets/ride_pref_history_tile.dart';
import '../../widgets/errors/bla_error_screen.dart';

const String blablaHomeImagePath = 'assets/images/blabla_home.png';

///
/// This screen allows user to:
/// - Enter his/her ride preference and launch a search on it
/// - Or select a last entered ride preferences and launch a search on it
///
class RidePrefScreen extends StatelessWidget {
  const RidePrefScreen({super.key});
  void onRidePrefSelected(BuildContext context, RidePreference newPreference) async {
    // Access the provider
    final ridesPreferencesProvider = Provider.of<RidesPreferencesProvider>(context, listen: false);
    
    // 1 - Update the current preference
    ridesPreferencesProvider.setCurrentPreference(newPreference);

    // 2 - Navigate to the rides screen (with a bottom to top animation)
    await Navigator.of(context).push(AnimationUtils.createBottomToTopRoute(RidesScreen()));
  }

  @override
  Widget build(BuildContext context) {
    // Watch the RidesPreferencesProvider
    final ridesPreferencesProvider = Provider.of<RidesPreferencesProvider>(context);
    
    // Get the current preference and past preferences
    RidePreference? currentRidePreference = ridesPreferencesProvider.currentPreference;
    AsyncValue<List<RidePreference>> pastPreferences = ridesPreferencesProvider.preferencesHistory;

    return Stack(
      children: [
        // 1 - Background Image
        const BlaBackground(),

        // 2 - Foreground content
        pastPreferences.isLoading
            ? BlaError(message: 'Loading...') // Loading state
            : pastPreferences.error != null
                ? BlaError(message: 'No connection. Try later') // Error state
                : Column(
          children: [
            SizedBox(height: BlaSpacings.m),
            Text(
              "Your pick of rides at low price",
              style: BlaTextStyles.heading.copyWith(color: Colors.white),
            ),
            SizedBox(height: 100),
            Container(
              margin: EdgeInsets.symmetric(horizontal: BlaSpacings.xxl),
              decoration: BoxDecoration(
                color: Colors.white, // White background
                borderRadius: BorderRadius.circular(16), // Rounded corners
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 2.1 Display the Form to input the ride preferences
                  RidePrefForm(
                    initialPreference: currentRidePreference,
                    onSubmit: (newPreference) => onRidePrefSelected(context, newPreference),
                  ),
                  SizedBox(height: BlaSpacings.m),

                  // 2.2 Optionally display a list of past preferences
                  SizedBox(
                    height: 200, // Set a fixed height
                    child: ListView.builder(
                      shrinkWrap: true, // Fix ListView height issue
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: pastPreferences.value!.length,
                      itemBuilder: (ctx, index) => RidePrefHistoryTile(
                        ridePref: pastPreferences.value![index],
                        onPressed: () => onRidePrefSelected(context, pastPreferences.value![index]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class BlaBackground extends StatelessWidget {
  const BlaBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 340,
      child: Image.asset(
        blablaHomeImagePath,
        fit: BoxFit.cover, // Adjust image fit to cover the container
      ),
    );
  }
}