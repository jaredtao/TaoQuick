#! /bin/bash
mkdir bin/release/TaoQuickApp.app/Contents/Resources/qml
cp -R bin/release/TaoQuick bin/release/TaoQuickApp.app/Contents/Resources/qml/TaoQuick
/usr/local/opt/qt/bin/macdeployqt bin/release/TaoQuickApp.app -qmldir=/usr/local/opt/qt/qml -verbose=1 -dmg
mv bin/release/TaoQuickApp.dmg bin/release/TaoQuickApp_macos10-14_xcode10-2.dmg
