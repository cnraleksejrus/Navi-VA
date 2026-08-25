import 'package:flutter/material.dart';
import '../models/driver_settings.dart';
import '../services/settings_service.dart';
import 'display_settings_screen.dart';
import '../models/display_settings.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, required this.initial});

  final DriverSettings initial;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late DriverSettings settings;

  @override
  void initState() {
    super.initState();
    settings = widget.initial;
  }

  Future<void> _save() async {
    await SettingsService().save(settings);
    if (mounted) Navigator.pop(context, settings);
  }

  void update(DriverSettings value) => setState(() => settings = value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fahrt-Einstellungen'),
        actions: [
          IconButton(
            onPressed: _save,
            icon: const Icon(Icons.check),
            tooltip: 'Speichern',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.map),
            title: const Text('Darstellung & Karte'),
            subtitle: const Text('Hell/Dunkel, 2D/3D, Norden, Höhe und mehr'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const DisplaySettingsScreen(
                  initial: DisplaySettings(),
                ),
              ),
            ),
          ),
          const Divider(),
          const Text(
            'Navigation',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          _switch('Autobahnen vermeiden', settings.avoidHighways,
              (v) => update(settings.copyWith(avoidHighways: v))),
          _switch('Mautstraßen vermeiden', settings.avoidTolls,
              (v) => update(settings.copyWith(avoidTolls: v))),
          _switch('Baustellen vermeiden', settings.avoidConstruction,
              (v) => update(settings.copyWith(avoidConstruction: v))),
          const SizedBox(height: 20),
          const Text(
            'Ampel & Green Wave',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          _switch('Ampeln anzeigen', settings.showTrafficLights,
              (v) => update(settings.copyWith(showTrafficLights: v))),
          _switch('Rot/Grün anzeigen', settings.showTrafficLightState,
              (v) => update(settings.copyWith(showTrafficLightState: v))),
          _switch('Green Wave aktivieren', settings.greenWave,
              (v) => update(settings.copyWith(greenWave: v))),
          _switch('Empfohlene Geschwindigkeit', settings.showRecommendedSpeed,
              (v) => update(settings.copyWith(showRecommendedSpeed: v))),
          const SizedBox(height: 20),
          const Text(
            'Warnungen',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          _switch('Baustellen', settings.showConstruction,
              (v) => update(settings.copyWith(showConstruction: v))),
          _switch('Unfälle', settings.showAccidents,
              (v) => update(settings.copyWith(showAccidents: v))),
          _switch('Sperrungen', settings.showClosures,
              (v) => update(settings.copyWith(showClosures: v))),
          _switch('Stau / Verkehr', settings.showTraffic,
              (v) => update(settings.copyWith(showTraffic: v))),
          const SizedBox(height: 20),
          const Text(
            'Sprache',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          _switch('Sprachansagen', settings.voiceGuidance,
              (v) => update(settings.copyWith(voiceGuidance: v))),
          _switch('Nur wichtige Ansagen', settings.voiceOnlyImportant,
              (v) => update(settings.copyWith(voiceOnlyImportant: v))),
          const SizedBox(height: 20),
          Text(
            'Geschwindigkeitslimit: ${settings.speedLimitKmh} km/h',
            style: const TextStyle(fontSize: 17),
          ),
          Slider(
            value: settings.speedLimitKmh.toDouble(),
            min: 20,
            max: 130,
            divisions: 22,
            label: '${settings.speedLimitKmh} km/h',
            onChanged: (v) =>
                update(settings.copyWith(speedLimitKmh: v.round())),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _save,
            icon: const Icon(Icons.save),
            label: const Text('Einstellungen speichern'),
          ),
        ],
      ),
    );
  }

  Widget _switch(
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }
}
