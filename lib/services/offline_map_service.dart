import 'dart:io';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class OfflineMapService {
  Future<Directory> _mapDir() async {
    final base = await getApplicationDocumentsDirectory();
    final dir = Directory('${base.path}/offline_maps');
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }
    return dir;
  }

  int _tileX(double lon, int zoom) =>
      ((lon + 180) / 360 * (1 << zoom)).floor();

  int _tileY(double lat, int zoom) {
    final latRad = lat * math.pi / 180;
    final n = 1 << zoom;
    return ((1 - math.log(math.tan(latRad) + 1 / math.cos(latRad)) / math.pi) /
            2 *
            n)
        .floor();
  }

  Future<int> downloadRegion({
    required double minLat,
    required double minLon,
    required double maxLat,
    required double maxLon,
    int minZoom = 12,
    int maxZoom = 13,
    void Function(int done, int total)? onProgress,
  }) async {
    final dir = await _mapDir();
    var done = 0;
    var total = 0;

    for (var z = minZoom; z <= maxZoom; z++) {
      final x1 = _tileX(minLon, z);
      final x2 = _tileX(maxLon, z);
      final y1 = _tileY(maxLat, z);
      final y2 = _tileY(minLat, z);
      total += (x2 - x1 + 1) * (y2 - y1 + 1);
    }

    for (var z = minZoom; z <= maxZoom; z++) {
      final x1 = _tileX(minLon, z);
      final x2 = _tileX(maxLon, z);
      final y1 = _tileY(maxLat, z);
      final y2 = _tileY(minLat, z);

      for (var x = x1; x <= x2; x++) {
        for (var y = y1; y <= y2; y++) {
          final target = File('${dir.path}/$z/$x/$y.png');
          if (!target.existsSync()) {
            final uri = Uri.parse(
              'https://tile.openstreetmap.org/$z/$x/$y.png',
            );
            final response = await http.get(
              uri,
              headers: {'User-Agent': 'Navi-VAPrototype/0.1'},
            );
            if (response.statusCode == 200) {
              target.parent.createSync(recursive: true);
              await target.writeAsBytes(response.bodyBytes);
            }
          }
          done++;
          onProgress?.call(done, total);
        }
      }
    }

    return done;
  }

  Future<int> storedFileCount() async {
    final dir = await _mapDir();
    if (!dir.existsSync()) return 0;
    return dir
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => file.path.endsWith('.png'))
        .length;
  }
}
