import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import './dummy_data/dummy_data.dart';
import './theme/theme.dart';
import './model/ride/locations.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Travel Form')),
        body: Center(child: TravelForm()),
      ),
    );
  }
}

class TravelForm extends StatefulWidget {
  @override
  _TravelFormState createState() => _TravelFormState();
}

class _TravelFormState extends State<TravelForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  int _passengerCount = 1;

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('EEE dd MMM').format(DateTime.now());
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        _dateController.text = DateFormat('EEE dd MMM').format(pickedDate);
      });
    }
  }

  Future<void> _selectLocation(BuildContext context, TextEditingController controller) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationPicker(
          locations: fakeLocations,
          initialValue: controller.text,
        ),
      ),
    );
    if (result != null) {
      setState(() {
        controller.text = result;
      });
    }
  }

  void _swapLocations() {
    String temp = _fromController.text;
    _fromController.text = _toController.text;
    _toController.text = temp;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Handle form submission logic here
      print('Leaving from: ${_fromController.text}');
      print('Going to: ${_toController.text}');
      print('Date: ${_dateController.text}');
      print('Passengers: $_passengerCount');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      height: 400,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: BlaColors.primary, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Leaving from TextField
            TextFormField(
              controller: _fromController,
              decoration: InputDecoration(
                labelText: 'Leaving from',
                prefixIcon: Icon(Icons.map),
                suffixIcon: IconButton(
                  icon: Icon(Icons.swap_horiz),
                  onPressed: _swapLocations,
                ),
              ),
              onTap: () {
                _selectLocation(context, _fromController);
              },
              validator: (value) {
                if (!fakeLocations.any((location) => location.name == value)) {
                  return 'The location you try to input isn\'t available in UK and France';
                }
                return null;
              },
            ),
            SizedBox(height: 8),

            // Going to TextField
            TextFormField(
              controller: _toController,
              decoration: InputDecoration(
                labelText: 'Going to',
                prefixIcon: Icon(Icons.map),
              ),
              onTap: () {
                _selectLocation(context, _toController);
              },
              validator: (value) {
                if (!fakeLocations.any((location) => location.name == value)) {
                  return 'The location you try to input isn\'t available in UK and France';
                }
                return null;
              },
            ),
            SizedBox(height: 8),

            // Date Input Field
            TextFormField(
              controller: _dateController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Date',
                prefixIcon: Icon(Icons.calendar_today),
              ),
              onTap: () => _selectDate(context),
            ),
            SizedBox(height: 8),

            // Number Input Field for Passengers
            Row(
              children: [
                
                SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: TextEditingController(text: _passengerCount.toString()),
                    decoration: InputDecoration(
                      labelText: 'Passengers',
                      prefixIcon: Icon(Icons.person),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _passengerCount = int.tryParse(value) ?? 1;
                      });
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+$')),
                      FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                    ],
                    minLines: 1,
                    maxLines: 1,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      _passengerCount = max(_passengerCount - 1, 1);
                    });
                  },
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      _passengerCount++;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 24),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 56, // Match the height of the input fields
              child: ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: BlaColors.primary, // Use primary color from theme
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LocationPicker extends StatefulWidget {
  final List<Location> locations;
  final String initialValue;

  LocationPicker({
    required this.locations,
    required this.initialValue,
  });

  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  late TextEditingController _searchController;
  late List<Location> _filteredLocations;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialValue);
    _filteredLocations = widget.locations;
  }

  void _filterLocations(String query) {
    setState(() {
      _filteredLocations = widget.locations.where((location) {
        return location.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search locations',
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: _filterLocations,
        ),
      ),
      body: ListView.builder(
        itemCount: _filteredLocations.length,
        itemBuilder: (context, index) {
          final location = _filteredLocations[index];
          return ListTile(
            title: Text(location.name),
            onTap: () {
              Navigator.of(context).pop(location.name);
            },
          );
        },
      ),
    );
  }
}
