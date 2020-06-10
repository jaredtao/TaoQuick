import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import "./Page"

Item {
    id: root
    width: 1440
    height: 960
    RectangularGlow {
        anchors.fill: parent
        visible: !splash.visible && view.active
        color: "#005fa3"
        spread: 1.0
        glowRadius: 2
    }
    Splash {
        id: splash
        anchors.fill: parent
    }
    Loader {
        id: loader
        source: "qrc:/Qml/MainPage.qml"
        asynchronous: true
        opacity: 0
        anchors{
            fill: parent
            margins: 2
        }
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
