class DriverSettings {
  const DriverSettings({
    this.avoidHighways = false,
    this.avoidTolls = false,
    this.avoidConstruction = false,
    this.showTrafficLights = true,
    this.showTrafficLightState = true,
    this.greenWave = true,
    this.voiceGuidance = true,
    this.voiceOnlyImportant = false,
    this.showConstruction = true,
    this.showAccidents = true,
    this.showClosures = true,
    this.showTraffic = true,
    this.showSpeedLimit = true,
    this.showCurrentSpeed = true,
    this.showRecommendedSpeed = true,
    this.speedLimitKmh = 50,
  });

  final bool avoidHighways;
  final bool avoidTolls;
  final bool avoidConstruction;
  final bool showTrafficLights;
  final bool showTrafficLightState;
  final bool greenWave;
  final bool voiceGuidance;
  final bool voiceOnlyImportant;
  final bool showConstruction;
  final bool showAccidents;
  final bool showClosures;
  final bool showTraffic;
  final bool showSpeedLimit;
  final bool showCurrentSpeed;
  final bool showRecommendedSpeed;
  final int speedLimitKmh;

  DriverSettings copyWith({
    bool? avoidHighways,
    bool? avoidTolls,
    bool? avoidConstruction,
    bool? showTrafficLights,
    bool? showTrafficLightState,
    bool? greenWave,
    bool? voiceGuidance,
    bool? voiceOnlyImportant,
    bool? showConstruction,
    bool? showAccidents,
    bool? showClosures,
    bool? showTraffic,
    bool? showSpeedLimit,
    bool? showCurrentSpeed,
    bool? showRecommendedSpeed,
    int? speedLimitKmh,
  }) {
    return DriverSettings(
      avoidHighways: avoidHighways ?? this.avoidHighways,
      avoidTolls: avoidTolls ?? this.avoidTolls,
      avoidConstruction: avoidConstruction ?? this.avoidConstruction,
      showTrafficLights: showTrafficLights ?? this.showTrafficLights,
      showTrafficLightState:
          showTrafficLightState ?? this.showTrafficLightState,
      greenWave: greenWave ?? this.greenWave,
      voiceGuidance: voiceGuidance ?? this.voiceGuidance,
      voiceOnlyImportant: voiceOnlyImportant ?? this.voiceOnlyImportant,
      showConstruction: showConstruction ?? this.showConstruction,
      showAccidents: showAccidents ?? this.showAccidents,
      showClosures: showClosures ?? this.showClosures,
      showTraffic: showTraffic ?? this.showTraffic,
      showSpeedLimit: showSpeedLimit ?? this.showSpeedLimit,
      showCurrentSpeed: showCurrentSpeed ?? this.showCurrentSpeed,
      showRecommendedSpeed:
          showRecommendedSpeed ?? this.showRecommendedSpeed,
      speedLimitKmh: speedLimitKmh ?? this.speedLimitKmh,
    );
  }
}
