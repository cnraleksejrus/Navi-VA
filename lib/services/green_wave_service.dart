class GreenWaveResult {
  const GreenWaveResult({
    required this.minKmh,
    required this.maxKmh,
    required this.canCatchCurrentGreen,
  });

  final double minKmh;
  final double maxKmh;
  final bool canCatchCurrentGreen;
}

class GreenWaveService {
  GreenWaveResult calculate({
    required double distanceMeters,
    required double greenInSeconds,
    required int speedLimitKmh,
  }) {
    if (distanceMeters <= 0 || greenInSeconds <= 0) {
      return const GreenWaveResult(
        minKmh: 0,
        maxKmh: 0,
        canCatchCurrentGreen: false,
      );
    }

    final requiredKmh = distanceMeters / greenInSeconds * 3.6;

    if (requiredKmh > speedLimitKmh) {
      return GreenWaveResult(
        minKmh: 0,
        maxKmh: speedLimitKmh.toDouble(),
        canCatchCurrentGreen: false,
      );
    }

    final min = (requiredKmh - 2).clamp(0, speedLimitKmh).toDouble();
    final max = (requiredKmh + 2).clamp(0, speedLimitKmh).toDouble();

    return GreenWaveResult(
      minKmh: min,
      maxKmh: max,
      canCatchCurrentGreen: true,
    );
  }
}
