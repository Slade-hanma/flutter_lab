import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/color_counters.dart';

class StatisticScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('StatisticScreen rebuilt');
    return Center(
      child: Consumer<ColorCounters>(
        builder: (context, colorCounters, child) {
          print('StatisticScreen Consumer rebuilt');
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Red Taps: ${colorCounters.redCount}',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              Text(
                'Blue Taps: ${colorCounters.blueCount}',
                style: TextStyle(fontSize: 24),
              ),
            ],
          );
        },
      ),
    );
  }
}
