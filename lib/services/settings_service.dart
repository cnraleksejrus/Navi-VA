import 'package:shared_preferences/shared_preferences.dart';
import '../models/driver_settings.dart';

class SettingsService {
  static const _prefix = 'navi_va.';

  Future<DriverSettings> load() async {
    final prefs = SharedPreferencesAsync();
    return DriverSettings(
      avoidHighways:
          await prefs.getBool('${_prefix}avoidHighways') ?? false,
      avoidTolls: await prefs.getBool('${_prefix}avoidTolls') ?? false,
      avoidConstruction:
          await prefs.getBool('${_prefix}avoidConstruction') ?? false,
      showTrafficLights:
          await prefs.getBool('${_prefix}showTrafficLights') ?? true,
      showTrafficLightState:
          await prefs.getBool('${_prefix}showTrafficLightState') ?? true,
      greenWave: await prefs.getBool('${_prefix}greenWave') ?? true,
      voiceGuidance:
          await prefs.getBool('${_prefix}voiceGuidance') ?? true,
      voiceOnlyImportant:
          await prefs.getBool('${_prefix}voiceOnlyImportant') ?? false,
      showConstruction:
          await prefs.getBool('${_prefix}showConstruction') ?? true,
      showAccidents:
          await prefs.getBool('${_prefix}showAccidents') ?? true,
      showClosures:
          await prefs.getBool('${_prefix}showClosures') ?? true,
      showTraffic:
          await prefs.getBool('${_prefix}showTraffic') ?? true,
      showSpeedLimit:
          await prefs.getBool('${_prefix}showSpeedLimit') ?? true,
      showCurrentSpeed:
          await prefs.getBool('${_prefix}showCurrentSpeed') ?? true,
      showRecommendedSpeed:
          await prefs.getBool('${_prefix}showRecommendedSpeed') ?? true,
      speedLimitKmh:
          await prefs.getInt('${_prefix}speedLimitKmh') ?? 50,
    );
  }

  Future<void> save(DriverSettings s) async {
    final prefs = SharedPreferencesAsync();
    await prefs.setBool('${_prefix}avoidHighways', s.avoidHighways);
    await prefs.setBool('${_prefix}avoidTolls', s.avoidTolls);
    await prefs.setBool('${_prefix}avoidConstruction', s.avoidConstruction);
    await prefs.setBool('${_prefix}showTrafficLights', s.showTrafficLights);
    await prefs.setBool(
      '${_prefix}showTrafficLightState',
      s.showTrafficLightState,
    );
    await prefs.setBool('${_prefix}greenWave', s.greenWave);
    await prefs.setBool('${_prefix}voiceGuidance', s.voiceGuidance);
    await prefs.setBool(
      '${_prefix}voiceOnlyImportant',
      s.voiceOnlyImportant,
    );
    await prefs.setBool('${_prefix}showConstruction', s.showConstruction);
    await prefs.setBool('${_prefix}showAccidents', s.showAccidents);
    await prefs.setBool('${_prefix}showClosures', s.showClosures);
    await prefs.setBool('${_prefix}showTraffic', s.showTraffic);
    await prefs.setBool('${_prefix}showSpeedLimit', s.showSpeedLimit);
    await prefs.setBool('${_prefix}showCurrentSpeed', s.showCurrentSpeed);
    await prefs.setBool(
      '${_prefix}showRecommendedSpeed',
      s.showRecommendedSpeed,
    );
    await prefs.setInt('${_prefix}speedLimitKmh', s.speedLimitKmh);
  }
}
