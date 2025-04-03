import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class StyledMapWidget extends StatefulWidget {
  const StyledMapWidget({super.key});

  @override
  State<StyledMapWidget> createState() => _StyledMapWidgetState();
}

class _StyledMapWidgetState extends State<StyledMapWidget> {
  final LatLng _center = LatLng(43.2220, 76.8512); // Алматы центр
  final MapController _mapController = MapController();
  double _zoom = 13.0;

  // Стили карты
  final List<MapStyle> _mapStyles = [
    MapStyle(
      name: 'Стандартная',
      urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
      subdomains: ['a', 'b', 'c'],
      icon: Icons.map,
      color: Colors.blue,
    ),
    MapStyle(
      name: 'Спутник',
      urlTemplate: 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
      subdomains: [],
      icon: Icons.satellite,
      color: Colors.green,
    ),
  ];

  int _currentStyleIndex = 0;

  @override
  Widget build(BuildContext context) {
    final currentStyle = _mapStyles[_currentStyleIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Карта Алматы'),
        backgroundColor: currentStyle.color,
        elevation: 2,
        actions: [
          IconButton(
            icon: Icon(currentStyle.icon),
            onPressed: _changeMapStyle,
            tooltip: 'Сменить стиль карты',
          ),
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: _centerMap,
            tooltip: 'Вернуться к центру',
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: _center,
              zoom: _zoom,
              onPositionChanged: (position, hasGesture) {
                if (hasGesture) {
                  setState(() {
                    _zoom = position.zoom!;
                  });
                }
              },
            ),
            children: [
              TileLayer(
                urlTemplate: currentStyle.urlTemplate,
                subdomains: currentStyle.subdomains,
                backgroundColor: Colors.blue[50],
                userAgentPackageName: 'com.example.app',
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: 'zoomIn',
                  mini: true,
                  onPressed: _zoomIn,
                  child: Icon(Icons.add),
                  backgroundColor: currentStyle.color,
                ),
                SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: 'zoomOut',
                  mini: true,
                  onPressed: _zoomOut,
                  child: Icon(Icons.remove),
                  backgroundColor: currentStyle.color,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _zoomIn() {
    _mapController.move(_mapController.center, _zoom + 1);
    setState(() {
      _zoom += 1;
    });
  }

  void _zoomOut() {
    _mapController.move(_mapController.center, _zoom - 1);
    setState(() {
      _zoom -= 1;
    });
  }

  void _centerMap() {
    _mapController.move(_center, _zoom);
  }

  void _changeMapStyle() {
    setState(() {
      _currentStyleIndex = (_currentStyleIndex + 1) % _mapStyles.length;
    });
  }
}

class MapStyle {
  final String name;
  final String urlTemplate;
  final List<String> subdomains;
  final IconData icon;
  final Color color;

  MapStyle({
    required this.name,
    required this.urlTemplate,
    required this.subdomains,
    required this.icon,
    required this.color,
  });
}