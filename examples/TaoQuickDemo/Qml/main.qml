import QtQuick 2.12
import QtQuick.Controls 2.12

import "./Page"

Item {
    id: root
    width: 1440
    height: 960

    Splash {
        id: splash
        anchors.fill: parent
    }
    Loader {
        id: loader
        source: "qrc:/Qml/MainPage.qml"
        asynchronous: true
        opacity: 0
        anchors.fill: parent
        Behavior on opacity {
            NumberAnimation { duration: 600 }
        }
        onLoaded: {
            timer.start()
        }
    }
    Timer {
        id: timer
        interval: 600
        repeat: false
        triggeredOnStart: false
        onTriggered: {
            loader.opacity = 1
            splash.visible = false
        }
    }
}
