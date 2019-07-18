#! /bin/bash
mkdir bin/release/TaoQuickDemo.app/Contents/Resources/qml
cp -R bin/release/TaoQuick bin/release/TaoQuickDemo.app/Contents/Resources/qml/TaoQuick
/usr/local/opt/qt/bin/macdeployqt bin/release/TaoQuickDemo.app -qmldir=/usr/local/opt/qt/qml -verbose=1 -dmg
mv bin/release/TaoQuickDemo.dmg bin/release/TaoQuickDemo_macos10-14_xcode10-2.dmg
