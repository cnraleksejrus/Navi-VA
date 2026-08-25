import 'package:flutter/material.dart';
import '../services/offline_map_service.dart';

class OfflineMapsScreen extends StatefulWidget {
  const OfflineMapsScreen({super.key});

  @override
  State<OfflineMapsScreen> createState() => _OfflineMapsScreenState();
}

class _OfflineMapsScreenState extends State<OfflineMapsScreen> {
  final service = OfflineMapService();
  double progress = 0;
  int stored = 0;
  bool downloading = false;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    final count = await service.storedFileCount();
    if (mounted) setState(() => stored = count);
  }

  Future<void> _download() async {
    setState(() {
      downloading = true;
      progress = 0;
    });

    try {
      await service.downloadRegion(
        minLat: 50.095,
        minLon: 8.655,
        maxLat: 50.125,
        maxLon: 8.710,
        minZoom: 12,
        maxZoom: 13,
        onProgress: (done, total) {
          if (mounted) setState(() => progress = done / total);
        },
      );
      await _refresh();
    } finally {
      if (mounted) setState(() => downloading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Offline-Karten')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Demo-Gebiet Frankfurt',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Die Demo lädt Karten-Tiles für ein festgelegtes Gebiet. '
              'Für Produktion sollte ein geeigneter Tile-Anbieter mit '
              'passenden Offline-/Caching-Rechten verwendet werden.',
            ),
            const SizedBox(height: 24),
            Text('Gespeicherte Tiles: $stored'),
            const SizedBox(height: 12),
            if (downloading) ...[
              LinearProgressIndicator(value: progress),
              const SizedBox(height: 8),
              Text('${(progress * 100).round()} %'),
            ] else
              FilledButton.icon(
                onPressed: _download,
                icon: const Icon(Icons.download),
                label: const Text('Karte herunterladen'),
              ),
          ],
        ),
      ),
    );
  }
}
