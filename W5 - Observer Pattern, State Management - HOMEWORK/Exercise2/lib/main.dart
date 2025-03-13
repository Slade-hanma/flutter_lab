import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/color_counters.dart';
import 'screen/home.dart'; // Assuming home.dart is the entry point

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ColorCounters(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Taps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(), // Use HomeScreen as the entry point
    );
  }
}
