import 'package:flutter_test/flutter_test.dart';
import 'package:navi_va/services/green_wave_service.dart';

void main() {
  test('respects speed limit', () {
    final result = GreenWaveService().calculate(
      distanceMeters: 200,
      greenInSeconds: 20,
      speedLimitKmh: 50,
    );

    expect(result.canCatchCurrentGreen, true);
    expect(result.minKmh, closeTo(34, 0.1));
    expect(result.maxKmh, closeTo(38, 0.1));
  });

  test('does not recommend illegal speed', () {
    final result = GreenWaveService().calculate(
      distanceMeters: 500,
      greenInSeconds: 10,
      speedLimitKmh: 50,
    );

    expect(result.canCatchCurrentGreen, false);
    expect(result.maxKmh, 50);
  });
}
