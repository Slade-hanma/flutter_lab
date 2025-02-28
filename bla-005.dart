import 'package:flutter/material.dart';
import 'theme/theme.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      home: Scaffold(
        appBar: AppBar(title: Text('Button Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // First Button: Contact Volodia
              SizedBox(
                width: 500,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Add your onPressed functionality here
                  },
                  icon: Icon(Icons.chat, color: BlaColors.primary),
                  label: Text(
                    'Contact Volodia',
                    style: BlaTextStyles.button.copyWith(color: BlaColors.primary),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: BlaColors.white, // Tertiary color
                  ),
                ),
              ),
              SizedBox(height: BlaSpacings.s), // Space between buttons
              // Second Button: Request to book
              SizedBox(
                width: 500,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Add your onPressed functionality here
                  },
                  icon: Icon(Icons.calendar_month, color: BlaColors.white),
                  label: Text(
                    'Request to book',
                    style: BlaTextStyles.button.copyWith(color: BlaColors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: BlaColors.primary, // Primary color
                    foregroundColor: BlaColors.white, // Text color
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}