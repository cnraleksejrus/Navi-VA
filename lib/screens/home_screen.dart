import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../models/driver_settings.dart';
import '../models/traffic_event.dart';
import '../services/green_wave_service.dart';
import '../services/location_service.dart';
import '../services/settings_service.dart';
import '../services/speech_service.dart';
import '../services/traffic_service.dart';
import '../widgets/event_marker.dart';
import 'offline_maps_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final mapController = MapController();
  final locationService = LocationService();
  final trafficService = TrafficService();
  final greenWaveService = GreenWaveService();
  final speechService = SpeechService();

  DriverSettings settings = const DriverSettings();
  List<TrafficEvent> events = [];
  Position? position;
  StreamSubscription<Position>? locationSubscription;
  bool loading = true;
  double currentSpeedKmh = 0;
  double recommendedMin = 0;
  double recommendedMax = 0;
  bool greenPossible = false;

  final LatLng demoCenter = const LatLng(50.1109, 8.6821);

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    locationSubscription?.cancel();
    speechService.stop();
    super.dispose();
  }

  Future<void> _init() async {
    settings = await SettingsService().load();
    events = trafficService.demoEvents();
    await speechService.init();
    await _locate();
    locationSubscription = locationService.stream().listen(_onPosition);
    if (mounted) setState(() => loading = false);
  }

  Future<void> _locate() async {
    try {
      final p = await locationService.currentPosition();
      _onPosition(p);
    } catch (_) {
      // Demo bleibt auch ohne GPS nutzbar.
    }
  }

  void _onPosition(Position p) {
    final speed = p.speed.isFinite && p.speed > 0 ? p.speed * 3.6 : 0;
    setState(() {
      position = p;
      currentSpeedKmh = speed;
    });
    _updateGreenWave(p);
  }

  void _updateGreenWave(Position p) {
    final nearestLights = events
        .where((e) => e.type == TrafficEventType.trafficLight)
        .toList()
      ..sort(
        (a, b) => Geolocator.distanceBetween(
          p.latitude,
          p.longitude,
          a.position.latitude,
          a.position.longitude,
        ).compareTo(
          Geolocator.distanceBetween(
            p.latitude,
            p.longitude,
            b.position.latitude,
            b.position.longitude,
          ),
        ),
      );

    if (nearestLights.isEmpty) return;

    final light = nearestLights.first;
    final distance = Geolocator.distanceBetween(
      p.latitude,
      p.longitude,
      light.position.latitude,
      light.position.longitude,
    );

    // Demo: 24 Sekunden bis zur nächsten passenden Grünphase.
    final result = greenWaveService.calculate(
      distanceMeters: distance,
      greenInSeconds: 24,
      speedLimitKmh: settings.speedLimitKmh,
    );

    if (mounted) {
      setState(() {
        recommendedMin = result.minKmh;
        recommendedMax = result.maxKmh;
        greenPossible = result.canCatchCurrentGreen;
      });
    }
  }

  Future<void> _openSettings() async {
    final result = await Navigator.push<DriverSettings>(
      context,
      MaterialPageRoute(
        builder: (_) => SettingsScreen(initial: settings),
      ),
    );
    if (result != null) {
      setState(() => settings = result);
      if (position != null) _updateGreenWave(position!);
    }
  }

  Future<void> _announce() async {
    if (!settings.voiceGuidance) return;
    if (greenPossible && recommendedMax > 0) {
      await speechService.speak(
        'Grüne Welle möglich. Empfohlene Geschwindigkeit '
        '${recommendedMin.round()} bis ${recommendedMax.round} Kilometer pro Stunde.',
      );
    } else {
      await speechService.speak(
        'Die aktuelle Grünphase ist mit dem erlaubten Tempo nicht sicher erreichbar.',
      );
    }
  }

  List<TrafficEvent> get visibleEvents {
    return events.where((event) {
      switch (event.type) {
        case TrafficEventType.trafficLight:
          return settings.showTrafficLights;
        case TrafficEventType.construction:
          return settings.showConstruction;
        case TrafficEventType.accident:
          return settings.showAccidents;
        case TrafficEventType.roadClosure:
          return settings.showClosures;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final center = position == null
        ? demoCenter
        : LatLng(position!.latitude, position!.longitude);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Navi-VA'),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const OfflineMapsScreen()),
            ),
            icon: const Icon(Icons.offline_pin),
            tooltip: 'Offline-Karten',
          ),
          IconButton(
            onPressed: _openSettings,
            icon: const Icon(Icons.tune),
            tooltip: 'Fahrt-Einstellungen',
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: center,
              initialZoom: 14.5,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.navi_va',
              ),
              if (position != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: center,
                      width: 44,
                      height: 44,
                      child: const Icon(
                        Icons.navigation,
                        size: 36,
                        color: Colors.indigo,
                      ),
                    ),
                  ],
                ),
              MarkerLayer(
                markers: visibleEvents.map((event) {
                  return Marker(
                    point: event.position,
                    width: 42,
                    height: 42,
                    child: EventMarker(event: event),
                  );
                }).toList(),
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: const [
                      LatLng(50.1109, 8.6821),
                      LatLng(50.1120, 8.6840),
                      LatLng(50.1140, 8.6810),
                    ],
                    strokeWidth: 5,
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            left: 12,
            right: 12,
            top: 12,
            child: _statusCard(),
          ),
          Positioned(
            left: 12,
            right: 12,
            bottom: 12,
            child: _eventsCard(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _announce,
        icon: const Icon(Icons.volume_up),
        label: const Text('Ansage'),
      ),
    );
  }

  Widget _statusCard() {
    final status = greenPossible ? 'GRÜNE WELLE' : 'NÄCHSTE PHASE ABWARTEN';
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Icon(
              greenPossible ? Icons.traffic : Icons.speed,
              color: greenPossible ? Colors.green : Colors.orange,
              size: 32,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    status,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  if (settings.showCurrentSpeed)
                    Text('Aktuell: ${currentSpeedKmh.round()} km/h'),
                  if (settings.showSpeedLimit)
                    Text('Limit: ${settings.speedLimitKmh} km/h'),
                  if (settings.greenWave &&
                      settings.showRecommendedSpeed &&
                      recommendedMax > 0)
                    Text(
                      greenPossible
                          ? 'Empfohlen: ${recommendedMin.round()}–${recommendedMax.round()} km/h'
                          : 'Mit Limit nicht in aktueller Phase erreichbar',
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _eventsCard() {
    final shown = visibleEvents.take(3).toList();
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Verkehr',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 6),
            ...shown.map(
              (e) => ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  e.type == TrafficEventType.trafficLight
                      ? Icons.traffic
                      : Icons.warning,
                ),
                title: Text(e.title),
                subtitle: Text(e.description),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
