import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/screens/rides/widgets/ride_pref_bar.dart';
import '../../model/ride/ride.dart';
import '../../model/ride_pref/ride_pref.dart';
import '../../service/rides_service.dart';
import '../../theme/theme.dart';
import 'widgets/rides_tile.dart';
import 'package:week_3_blabla_project/screens/ride_pref/widgets/ride_pref_form.dart'; // Import the RidePrefForm

class RidesScreen extends StatefulWidget {
  final RidePref initialRidePref;

  const RidesScreen({super.key, required this.initialRidePref});

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
  final RidesService ridesService = RidesService();
  late RidePref currentRidePref; // Create a variable for current preferences

  @override
  void initState() {
    super.initState();
    currentRidePref = widget.initialRidePref; // Initialize it with the initial preferences
  }

  List<Ride> get matchingRides =>
      ridesService.getRidesFor(currentRidePref, null); // Use currentRidePref

  void onRidePrefPressed() async {
    // Open a modal to edit the ride preferences
    final updatedRidePref = await showDialog<RidePref>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Ride Preferences'),
          content: RidePrefForm(initRidePref: currentRidePref), // Use currentRidePref
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close without saving
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Return the updated preferences
                Navigator.of(context).pop(currentRidePref); // Return the updated preferences
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );

    if (updatedRidePref != null) {
      // Call the service to update the preferences
      ridesService.updateRidePref(updatedRidePref); // Ensure this method exists

      setState(() {
        currentRidePref = updatedRidePref; // Update the current preferences
      });
    }
  }

  void onFilterPressed() {
    print("onFilterPressed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
            left: BlaSpacings.m, right: BlaSpacings.m, top: BlaSpacings.s),
        child: Column(
          children: [
            // Top search Search bar
            RidePrefBar(
              ridePref: currentRidePref, // Use currentRidePref
              onRidePrefPressed: onRidePrefPressed,
              onFilterPressed: onFilterPressed,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: matchingRides.length,
                itemBuilder: (ctx, index) => RideTile(
                  ride: matchingRides[index],
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
