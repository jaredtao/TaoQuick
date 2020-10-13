import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12

import "../../"
Item {
    id: r
    property int percent: 0

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
        case TCircleProgress.BarType.SucceedOrFailed:
            return percent === 100 ? __succeedColor : __failedColor
        default:
            return __blueColor
        }
    }

    property string text: String("%1%").arg(percent)
    property var barType: TCircleProgress.BarType.Text
    Rectangle {
        id: back
        color: "transparent"
        anchors.fill: parent
        border.color: percent === 100 ? frontColor : backgroundColor
        border.width: 10
        radius: width / 2
    }
    Text {
        id: t
        enabled: barType === TCircleProgress.BarType.Text
        visible: enabled
        text: r.text
        anchors.centerIn: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }
    Image {
        id: image
        source: percent === 100 ? "ok.png" : "fail.png"
        enabled: barType === TCircleProgress.BarType.SucceedOrFailed
        visible: enabled
        scale: 2
        anchors.centerIn: parent
    }
    ConicalGradient {
        anchors.fill: back
        source: back
        enabled: percent != 100
        visible: enabled
        smooth: true
        antialiasing: true
        gradient: Gradient {
            GradientStop { position: 0.0; color: frontColor }
            GradientStop { position: percent / 100 ; color: frontColor }
            GradientStop { position: percent / 100 + 0.001; color: backgroundColor }
            GradientStop { position: 1.0; color: backgroundColor }
        }
    }
}
