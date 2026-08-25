import 'package:latlong2/latlong.dart';
import '../models/traffic_event.dart';

class TrafficService {
  // Demo-Daten. In Produktion hier API/Backend anschließen.
  List<TrafficEvent> demoEvents() {
    return const [
      TrafficEvent(
        id: 'light-1',
        title: 'Ampel',
        description: 'Demo: aktuelle Phase Rot',
        type: TrafficEventType.trafficLight,
        position: LatLng(50.1109, 8.6821),
        lightState: TrafficLightState.red,
      ),
      TrafficEvent(
        id: 'light-2',
        title: 'Ampel',
        description: 'Demo: aktuelle Phase Grün',
        type: TrafficEventType.trafficLight,
        position: LatLng(50.1120, 8.6840),
        lightState: TrafficLightState.green,
      ),
      TrafficEvent(
        id: 'construction-1',
        title: 'Baustelle',
        description: 'Fahrbahn verengt',
        type: TrafficEventType.construction,
        position: LatLng(50.1088, 8.6798),
      ),
      TrafficEvent(
        id: 'accident-1',
        title: 'Verkehrsunfall',
        description: 'Demo-Meldung: Unfall voraus',
        type: TrafficEventType.accident,
        position: LatLng(50.1098, 8.6860),
      ),
      TrafficEvent(
        id: 'closure-1',
        title: 'Straßensperrung',
        description: 'Demo-Meldung: Straße gesperrt',
        type: TrafficEventType.roadClosure,
        position: LatLng(50.1140, 8.6810),
      ),
    ];
  }
}
