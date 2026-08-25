# Navi-VA für Android

Das Projekt enthält jetzt den vollständigen Android-Host (`android/`).

## Start in Android Studio

1. Flutter SDK und Android SDK installieren.
2. Projekt öffnen.
3. `flutter pub get` ausführen.
4. Android-Handy per USB-Debugging verbinden oder Emulator starten.
5. `flutter run`.

## APK

Debug:
`flutter build apk --debug`

Release:
`flutter build apk --release`

Für eine Veröffentlichung im Play Store muss eine eigene Release-Signatur eingerichtet werden.

## Hinweis

Die App enthält derzeit Demo-Verkehrsdaten. Echte Live-Ampelphasen,
Baustellen, Unfälle, Sperrungen und Routingdaten müssen anschließend an
geeignete Live-Datenquellen angeschlossen werden.
