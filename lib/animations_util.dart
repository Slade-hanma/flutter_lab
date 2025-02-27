import 'package:flutter/material.dart';
import './model/ride/locations.dart';

 Route<T> createBottomToTopRoute<T>(Widget screen) {
  const begin = Offset(0.0, 1.0); // Start off-screen at the bottom
  const end = Offset(0.0, 0.0);   // End at the original position

  return _createAnimatedRoute(screen, begin, end);
}

 Route<T> _createAnimatedRoute<T>(
    Widget screen, Offset begin, Offset end) {
  return PageRouteBuilder<T>(
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const curve = Curves.easeInOut;
      final tween = Tween<Offset>(begin: begin, end: end);
      final offsetAnimation = animation.drive(tween.chain(CurveTween(curve: curve)));

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
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
