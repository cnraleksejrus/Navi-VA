#!/usr/bin/env bash
set -euo pipefail

flutter create --platforms=android,ios .
flutter pub get

echo
echo "Navi-VA wurde vorbereitet."
echo "Jetzt: flutter run"
