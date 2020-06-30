import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Item {
    id: rootView
    width: 1440
    height: 960
    Component.onCompleted: {
        view.initAppInfo()
        trans.loadFolder(appPath + "/Trans")
    }
    RectangularGlow {
        id: glow
        anchors.fill: parent
        visible: false
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
        source: "MainPage.qml"
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
        onOpacityChanged: {
            if (opacity === 1) {
                glow.visible = Qt.binding(function() {return !splash.visible && view.active;})
            }
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
