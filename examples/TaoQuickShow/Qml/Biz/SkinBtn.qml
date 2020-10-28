import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0

CusButton_Image {
    btnImgUrl: imgPath + (hovered
                          || pressed ? "Window/skin_white.png" : "Window/skin_gray.png")
    tipText: qsTr("skin") + trans.transString
    onClicked: {
        skinBox.show()
    }
    CusPopup {
        id: skinBox
        barColor: CusConfig.controlColor
        backgroundWidth: 270
        backgroundHeight: 180
        borderColor: CusConfig.controlBorderColor
        contentItem: GridView {
            anchors.fill: parent
            anchors.margins: 10
            model: CusConfig.themes
            cellWidth: 80
            cellHeight: 80
            clip: true
            delegate: Item {
                width: 80
                height: 80
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: 4
                    color: model.themeColor
                }
                Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                    border.color: model.themeColor
                    border.width: 2
                    visible: a.containsMouse
                }
                CusLabel {
                    anchors {
                        centerIn: parent
                    }
                    horizontalAlignment: Text.AlignHCenter
                    color: "white"
                    text: qsTr(model.name) + trans.transString
                }
                Rectangle {
                    x: parent.width - width
                    y: parent.height - height
                    width: 20
                    height: width
                    radius: width / 2
                    color: model.themeColor
                    border.width: 3
                    border.color: CusConfig.controlBorderColor
                    visible: CusConfig.currentTheme === index
                }
                MouseArea {
                    id: a
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        CusConfig.currentTheme = index
                    }
                }
            }
        }
    }
}
