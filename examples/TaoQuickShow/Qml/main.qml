import QtQuick 2.9
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0
import TaoQuick 1.0

Rectangle {
    id: rootView
    width: 1440
    height: 900
    color: "lightblue"
//    Component.onCompleted: {
//        appInfo.splashShow = false;
//    }
//    Splash {
//        id: splash
//        anchors.centerIn: parent
//    }
//    Loader {
//        id: loader
//        source: "MainPage.qml"
//        asynchronous: true
//        opacity: 0
//        anchors{
//            fill: parent
//            margins: 2
//        }
//        Behavior on opacity {
//            NumberAnimation { duration: 800 }
//        }
//        onLoaded: {
//            timer.start()
//        }
//    }
//    Timer {
//        id: timer
//        interval: 800
//        repeat: false
//        triggeredOnStart: false
//        onTriggered: {
//            loader.opacity = 1
//            splash.visible = false
//        }
//    }
    CusButton_Blue {
        text: "hello"
        x: 80
        y: 200
        width: 120
        height: 30
    }
    TFPS {
        y: 10
        x: 10
    }
    CusButton_Blue {
        anchors.centerIn: parent
        text: qsTr("Chinese")
    }
}
