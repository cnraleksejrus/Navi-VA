import 'package:flutter/material.dart';
import '../models/traffic_event.dart';

class EventMarker extends StatelessWidget {
  const EventMarker({super.key, required this.event});

  final TrafficEvent event;

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;

    switch (event.type) {
      case TrafficEventType.trafficLight:
        icon = Icons.traffic;
        color = event.lightState == TrafficLightState.green
            ? Colors.green
            : Colors.red;
      case TrafficEventType.construction:
        icon = Icons.construction;
        color = Colors.orange;
      case TrafficEventType.accident:
        icon = Icons.warning;
        color = Colors.red;
      case TrafficEventType.roadClosure:
        icon = Icons.block;
        color = Colors.black87;
    }

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(blurRadius: 5, color: Colors.black26),
        ],
        border: Border.all(color: color, width: 2),
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }
}
