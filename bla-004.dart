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
        appBar: AppBar(title: Text('Travel Form')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Input Text: Leaving From
                SizedBox(
                  width: 500,
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Leaving From',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.map), // Map icon on the left
                      suffixIcon: Icon(Icons.swap_horiz), // Swap icon on the right
                    ),
                  ),
                ),
                SizedBox(height: 16.0), // Space between fields

                // Input Text: Going To
                SizedBox(
                  width: 500,
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Going To',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.map), // Map icon on the left
                    ),
                  ),
                ),
                SizedBox(height: 16.0), // Space between fields

                // Text Field: Date
                SizedBox(
                  width: 500,
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Date',
                      hintText: 'Mon 22 June',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.calendar_today), // Calendar icon on the left
                    ),
                  ),
                ),
                SizedBox(height: 16.0), // Space between fields

                // Input Text: Passenger Number
                SizedBox(
                  width: 500,
                  height: 50,
                  child: TextField(
                    controller: TextEditingController(text: '1'), // Default value 1
                    decoration: InputDecoration(
                      labelText: 'Passenger Number',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person), // Person icon on the left
                    ),
                    keyboardType: TextInputType.number, // Numeric input
                  ),
                ),
                SizedBox(height: 16.0), // Space between fields

                // Primary Submit Button
                SizedBox(
                  width: 500,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your onPressed functionality here
                    },
                    child: Text('Submit'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: BlaColors.primary, // Primary color
                      textStyle: TextStyle(color: BlaColors.white), // Text color
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
