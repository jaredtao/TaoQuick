import QtQuick 2.12
import QtQuick.Controls 2.12
import TaoQuick 1.0
import "qrc:/TaoQuick"
TImageBtn {

    imageUrl: imgPath + (containsMouse ? "Window/skin_white.png" : "Window/skin_gray.png")
    onClicked: {
        skinBox.show()
    }
    TPopup {
        id: skinBox
        barColor: gConfig.reserverColor
        backgroundWidth: 280
        backgroundHeight: 180
        contentItem: GridView {
            anchors.fill: parent
            anchors.margins: 10
            model: gConfig.themes
            cellWidth: 80
            cellHeight: 80
            clip: true
            delegate: Item {
                width: 80
                height: 80
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: 4
                    height: width
                    color: model.titleBackground
                }
                Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                    border.color: model.titleBackground
                    border.width: 2
                    visible: a.containsMouse
                }
                Text {
                    anchors {
                        left: parent.left
                        bottom: parent.bottom
                        leftMargin: 8
                        bottomMargin: 8
                    }
                    color: "white"
                    text: trans.trans(model.name) + trans.transString
                }
                Rectangle {
                    x: parent.width - width
                    y: parent.height - height
                    width: 20
                    height: width
                    radius: width / 2
                    color: model.titleBackground
                    border.width: 3
                    border.color: gConfig.reserverColor
                    visible: gConfig.currentTheme === index
                }
                MouseArea {
                    id: a
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        gConfig.currentTheme = index
                    }
                }
            }
        }

    }
}
