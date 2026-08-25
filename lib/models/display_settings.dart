enum ThemeModePreference { light, dark, system }
enum MapDimension { twoD, threeD, automatic }
enum MapOrientation { northUp, headingUp, automatic }
enum HeightUnit { meters, feet }

class DisplaySettings {
  const DisplaySettings({
    this.themeMode = ThemeModePreference.system,
    this.mapDimension = MapDimension.automatic,
    this.mapOrientation = MapOrientation.automatic,
    this.show3dBuildings = true,
    this.showAltitude = true,
    this.showHeading = true,
    this.showGpsAccuracy = false,
    this.heightUnit = HeightUnit.meters,
  });

  final ThemeModePreference themeMode;
  final MapDimension mapDimension;
  final MapOrientation mapOrientation;
  final bool show3dBuildings;
  final bool showAltitude;
  final bool showHeading;
  final bool showGpsAccuracy;
  final HeightUnit heightUnit;

  DisplaySettings copyWith({
    ThemeModePreference? themeMode,
    MapDimension? mapDimension,
    MapOrientation? mapOrientation,
    bool? show3dBuildings,
    bool? showAltitude,
    bool? showHeading,
    bool? showGpsAccuracy,
    HeightUnit? heightUnit,
  }) => DisplaySettings(
    themeMode: themeMode ?? this.themeMode,
    mapDimension: mapDimension ?? this.mapDimension,
    mapOrientation: mapOrientation ?? this.mapOrientation,
    show3dBuildings: show3dBuildings ?? this.show3dBuildings,
    showAltitude: showAltitude ?? this.showAltitude,
    showHeading: showHeading ?? this.showHeading,
    showGpsAccuracy: showGpsAccuracy ?? this.showGpsAccuracy,
    heightUnit: heightUnit ?? this.heightUnit,
  );
}
