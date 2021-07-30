import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."
CusImage {
    id: cusImageTip

    property alias tipItem: toolTip
    property alias tipText: toolTip.text
    property alias tipVisible: toolTip.visible
    property alias tipDelay: toolTip.delay
    property alias tipTimeout: toolTip.timeout

    property alias containsMouse: hoverArea.containsMouse
    property alias containsPress: hoverArea.containsPress
    BasicTooltip {
        id: toolTip
        visible: cusImageTip.enabled && String(text).length && hoverArea.containsMouse
    }
    TransArea {
        id: hoverArea
        anchors.fill: parent
        hoverEnabled: true
    }
}

