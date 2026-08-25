# Navi-VA

Cross-platform Flutter-Prototyp für Android und iPhone.

## Enthalten

- Kartenansicht mit OpenStreetMap-Tiles
- GPS-Standort
- Demo-Ampeln, Baustellen, Unfall und Sperrung
- Green-Wave-Berechnung innerhalb des Tempolimits
- Sprachansagen über Text-to-Speech
- frei einstellbare Fahreroptionen
- lokale Speicherung der Einstellungen
- Offline-Karten-Download als Tile-Paket mit lokalem Index
- klare Trennung zwischen Demo-Daten und späteren Live-APIs

## Wichtig

Die Demo behauptet nicht, echte Live-Ampelphasen oder Live-Unfälle zu kennen.
Dafür müssen später offizielle bzw. lizenzierte Datenquellen angebunden werden.

Auch die Karten-Tiles müssen entsprechend den Nutzungsbedingungen des jeweiligen Tile-Anbieters verwendet werden.
Für einen produktiven Betrieb sollte ein eigener/kommerzieller Tile-Anbieter verwendet werden.

## Start

1. Flutter installieren.
2. Projektordner öffnen.
3. Einmal die nativen Plattformordner erzeugen:

```bash
flutter create --platforms=android,ios .
```

4. Abhängigkeiten installieren:

```bash
flutter pub get
```

5. Starten:

```bash
flutter run
```

## Android

Für GPS müssen die Standort-Berechtigungen in `android/app/src/main/AndroidManifest.xml`
gesetzt werden. Die Datei `docs/android_manifest_snippet.xml` enthält den einzufügenden Block.

## iOS

Für GPS muss in `ios/Runner/Info.plist` `NSLocationWhenInUseUsageDescription`
gesetzt werden. Siehe `docs/ios_info_plist_snippet.xml`.

## Produktionsausbau

- echter Routing-Service
- echte Ampelphasen
- offizielle Baustellen-/Unfalldaten
- Hintergrundnavigation
- Push-/Audio-Warnungen
- robuste Offline-Routingdaten statt nur Karten-Tiles
- Datenschutz, Logging, Crash Reporting und App-Store-Konfiguration


## Darstellung & Karte

Navi-VA enthält vorbereitete Einstellungen für:
- Hell / Dunkel / Automatisch
- 2D / 3D / Automatisch
- 3D-Gebäude
- Norden oben / Fahrtrichtung oben / Automatisch
- aktuelle Höhe in Meter oder Fuß
- Kompass und GPS-Genauigkeit

Die aktuelle Kartenengine ist 2D. Für echte 3D-Gebäude muss später ein
3D-fähiger Kartenrenderer/Datenanbieter angeschlossen werden.
