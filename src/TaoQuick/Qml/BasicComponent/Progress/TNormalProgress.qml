import QtQuick 2.12
import QtQuick.Controls 2.12
import TaoQuick 1.0
import "../../"
Item {
    id: r
    property int percent: 0
    implicitWidth: 200
    implicitHeight: 16

    enum BarType {
        Text,
        SucceedOrFailed,
        NoBar
    }
    readonly property color __backColor: "#f5f5f5"
    readonly property color __blueColor: "#1890ff"
    readonly property color __succeedColor: "#52c41a"
    readonly property color __failedColor: "#f5222d"

    property color backgroundColor: __backColor
    property color frontColor: {
        switch (barType) {
        case TNormalProgress.BarType.SucceedOrFailed:
            return percent === 100 ? __succeedColor : __failedColor
        default:
            return __blueColor
        }
    }
    property string text: String("%1%").arg(percent)
    property int gradientIndex: -1
    property bool flicker: false
    property var barType: TNormalProgress.BarType.Text
    Text {
        id: t
        enabled: barType === TNormalProgress.BarType.Text
        visible: enabled
        text: r.text
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
    }
    Image {
        id: image
        source: percent === 100 ? "qrc:/Core/Image/ProgressBar/ok_circle.png" : "qrc:/Core/Image/ProgressBar/fail_circle.png"
        height: parent.height
        width: height
        enabled: barType === TNormalProgress.BarType.SucceedOrFailed
        visible: enabled
        anchors.right: parent.right
    }

    property var __right: {
        switch (barType) {
        case TNormalProgress.BarType.Text:
            return t.left
        case TNormalProgress.BarType.SucceedOrFailed:
            return image.left
        default:
            return r.right
        }
    }
    Rectangle {
        id: back
        anchors.left: parent.left
        anchors.right: __right
        anchors.rightMargin: 4
        height: parent.height
        radius: height / 2
        color: backgroundColor
        Rectangle {
            id: front
            width: percent / 100 * parent.width
            height: parent.height
            radius: parent.radius
            color: frontColor
            gradient: gradientIndex === -1 ? null : gradientIndex
            Rectangle {
                id: flick
                height: parent.height
                width: 0
                radius: parent.radius
                color: Qt.lighter(parent.color, 1.2)
                enabled: flicker
                visible: enabled
                NumberAnimation on width {
                    running: visible
                    from: 0
                    to: front.width
                    duration: 1000
                    loops: Animation.Infinite;
                }
            }
        }
    }
}
