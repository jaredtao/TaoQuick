import QtQuick 2.0
import QtQuick.Controls 2.0
Rectangle {
    width: 28
    height: width
    radius: width / 2
    color: gConfig.themeColor
    border.width: 4
    border.color: gConfig.background
    property alias text: t.text
    property alias textItem: t

    TText {
        id: t
        anchors.centerIn: parent
    }
}
