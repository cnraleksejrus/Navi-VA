import 'package:flutter/material.dart';
import '../models/display_settings.dart';

class DisplaySettingsScreen extends StatefulWidget {
  const DisplaySettingsScreen({super.key, required this.initial});
  final DisplaySettings initial;

  @override
  State<DisplaySettingsScreen> createState() => _DisplaySettingsScreenState();
}

class _DisplaySettingsScreenState extends State<DisplaySettingsScreen> {
  late DisplaySettings settings;
  @override
  void initState() { super.initState(); settings = widget.initial; }
  void update(DisplaySettings v) => setState(() => settings = v);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Darstellung & Karte'),
      actions: [
        IconButton(
          onPressed: () => Navigator.pop(context, settings),
          icon: const Icon(Icons.check),
        )
      ],
    ),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Helligkeit', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        for (final item in [
          (ThemeModePreference.light, 'Hell'),
          (ThemeModePreference.dark, 'Dunkel'),
          (ThemeModePreference.system, 'Automatisch'),
        ])
          RadioListTile(
            title: Text(item.$2),
            value: item.$1,
            groupValue: settings.themeMode,
            onChanged: (v) => update(settings.copyWith(themeMode: v)),
          ),
        const Divider(),
        const Text('Kartenansicht', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        for (final item in [
          (MapDimension.twoD, '2D'),
          (MapDimension.threeD, '3D'),
          (MapDimension.automatic, 'Automatisch'),
        ])
          RadioListTile(
            title: Text(item.$2),
            value: item.$1,
            groupValue: settings.mapDimension,
            onChanged: (v) => update(settings.copyWith(mapDimension: v)),
          ),
        SwitchListTile(
          title: const Text('3D-Gebäude'),
          value: settings.show3dBuildings,
          onChanged: (v) => update(settings.copyWith(show3dBuildings: v)),
        ),
        const Divider(),
        const Text('Ausrichtung', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        for (final item in [
          (MapOrientation.northUp, 'Norden oben'),
          (MapOrientation.headingUp, 'Fahrtrichtung oben'),
          (MapOrientation.automatic, 'Automatisch'),
        ])
          RadioListTile(
            title: Text(item.$2),
            value: item.$1,
            groupValue: settings.mapOrientation,
            onChanged: (v) => update(settings.copyWith(mapOrientation: v)),
          ),
        const Divider(),
        const Text('Informationen', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SwitchListTile(
          title: const Text('Aktuelle Höhe anzeigen'),
          value: settings.showAltitude,
          onChanged: (v) => update(settings.copyWith(showAltitude: v)),
        ),
        SwitchListTile(
          title: const Text('Kompass/Fahrtrichtung anzeigen'),
          value: settings.showHeading,
          onChanged: (v) => update(settings.copyWith(showHeading: v)),
        ),
        SwitchListTile(
          title: const Text('GPS-Genauigkeit anzeigen'),
          value: settings.showGpsAccuracy,
          onChanged: (v) => update(settings.copyWith(showGpsAccuracy: v)),
        ),
        DropdownButtonFormField<HeightUnit>(
          value: settings.heightUnit,
          decoration: const InputDecoration(labelText: 'Höheneinheit'),
          items: const [
            DropdownMenuItem(value: HeightUnit.meters, child: Text('Meter')),
            DropdownMenuItem(value: HeightUnit.feet, child: Text('Fuß')),
          ],
          onChanged: (v) => update(settings.copyWith(heightUnit: v)),
        ),
      ],
    ),
  );
}
