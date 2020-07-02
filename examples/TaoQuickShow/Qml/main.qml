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
    Splash {
        id: splash
        anchors.centerIn: parent
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
            NumberAnimation { duration: 800 }
        }
        onLoaded: {
            timer.start()
        }
    }
    Timer {
        id: timer
        interval: 800
        repeat: false
        triggeredOnStart: false
        onTriggered: {
            loader.opacity = 1
            splash.visible = false
        }
    }
}
