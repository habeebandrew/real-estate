import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:pro_2/Util/constants.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key});

  @override
  _SelectLocationScreenState createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  final MapController _mapController = MapController();
  LocationData? _currentLocation;
  LatLng? _selectedPoint;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    var location = Location();

    try {
      var userLocation = await location.getLocation();
      setState(() {
        _currentLocation = userLocation;
      });
    } on Exception {
      _currentLocation = null;
    }

    location.onLocationChanged.listen((LocationData newLocation) {
      setState(() {
        _currentLocation = newLocation;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
        actions: [
          TextButton(
            onPressed: () {
              if (_selectedPoint != null) {
                Navigator.pop(context, _selectedPoint);
              }
            },
            child: const Text('Confirm', style: TextStyle(color: Constants.mainColor,fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: _currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: LatLng(
            _currentLocation!.latitude!,
            _currentLocation!.longitude!,
          ),
          initialZoom: 15.0,
          onTap: (tapPosition, point) {
            setState(() {
              _selectedPoint = point;
            });
          },
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          ),
          MarkerLayer(
            markers: [
              if (_selectedPoint != null)
                Marker(
                  point: _selectedPoint!,
                  width: 80.0,
                  height: 80.0,
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 40.0,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
