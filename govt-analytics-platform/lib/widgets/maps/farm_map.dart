// widgets/maps/farm_map.dart
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../models/farm.dart';

class FarmMap extends StatelessWidget {
  final List<Farm> farms;

  const FarmMap({Key? key, required this.farms}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(20.5937, 78.9629), // Center of India
        zoom: 5.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayer(
          markers: farms.map((farm) {
            Color markerColor;
            switch (farm.riskLevel) {
              case 'high':
                markerColor = Colors.red;
                break;
              case 'medium':
                markerColor = Colors.orange;
                break;
              case 'low':
              default:
                markerColor = Colors.green;
            }

            return Marker(
              point: LatLng(farm.latitude, farm.longitude),
              width: 40,
              height: 40,
              builder: (ctx) => Icon(
                Icons.location_on,
                color: markerColor,
                size: 40,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}