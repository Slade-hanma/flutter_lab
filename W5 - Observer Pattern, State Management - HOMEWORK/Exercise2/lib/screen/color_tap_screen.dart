import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/color_counters.dart';

class ColorTapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('ColorTapScreen rebuilt');
    return Center(
      child: Consumer<ColorCounters>(
        builder: (context, colorCounters, child) {
          print('ColorTapScreen Consumer rebuilt');
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: colorCounters.incrementRed,
                child: Text('Red Taps: ${colorCounters.redCount}'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: colorCounters.incrementBlue,
                child: Text('Blue Taps: ${colorCounters.blueCount}'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
