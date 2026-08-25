import 'package:latlong2/latlong.dart';

enum TrafficEventType {
  trafficLight,
  construction,
  accident,
  roadClosure,
}

enum TrafficLightState {
  red,
  green,
  unknown,
}

class TrafficEvent {
  const TrafficEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.position,
    this.lightState,
    this.distanceMeters = 0,
  });

  final String id;
  final String title;
  final String description;
  final TrafficEventType type;
  final LatLng position;
  final TrafficLightState? lightState;
  final double distanceMeters;
}
