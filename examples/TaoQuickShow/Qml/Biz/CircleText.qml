import QtQuick 2.0
import QtQuick.Controls 2.0
import TaoQuick 1.0

Rectangle {
    width: 28
    height: width
    radius: width / 2
    color: CusConfig.themeColor
    border.width: CusConfig.controlBorderRadius
    border.color: CusConfig.controlBorderColor
    property alias text: t.text
    property alias textItem: t

    BasicText {
        id: t
        anchors.centerIn: parent
    }
}
