import QtQuick 2.9
import QtQuick.Controls 2.2
import "../.."
Item {
    property int fps: 60

    property int frameCount: 0
    property color textColor: "#f7e08c"
    implicitWidth: 100
    implicitHeight: 36
    Image {
        id: spinner
        source: CusConfig.imagePathPrefix + "spinner.png"
        width: 32
        height: 32
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        RotationAnimation on rotation {
            from: 0
            to: 360
            running: true
            loops: Animation.Infinite
            duration: 1000
        }
        onRotationChanged: frameCount++
    }
    BasicText {
        anchors.left: spinner.right
        anchors.verticalCenter: parent.verticalCenter
        text: "FPS " + fps
        font.pixelSize: 18
        style: Text.Outline
        styleColor: "#606060"

        color: textColor
    }
    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
            fps = frameCount
            frameCount = 0
        }
    }
}
