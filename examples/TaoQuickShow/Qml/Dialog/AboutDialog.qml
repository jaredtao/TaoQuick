import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0
//import QtGraphicalEffects 1.0
import "../Biz"

Popup {
    id: root
    width: 680
    height: 460
    modal: true
    background: Item {
        width: root.width
        height: root.height
        Rectangle {
            id: back
            anchors {
                fill: parent
                margins: 4
            }
            radius: 4
            color: CusConfig.themeColor

            MoveArea {
                anchors.fill: parent
                control: root
                onMove: {
                    root.x += xOffset
                    root.y += yOffset
                }
            }
            CusImage {
                id: img
                anchors.left: parent.left
                anchors.leftMargin: 2
                anchors.verticalCenter: parent.verticalCenter
                source: imgPath + "logo/milk.png"
            }
            CusButton {
                id: closeBtn
                text: qsTr("Close") + trans.transString
                width: 80
                height: 38
                radius: 8
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 4
                onClicked: {
                    root.close()
                }
            }
            Column {
                anchors.left: img.right
                anchors.leftMargin: 4
                anchors.top: parent.top
                anchors.topMargin: 4
                anchors.bottom: closeBtn.top
                anchors.bottomMargin: 260
                anchors.right: parent.right
                spacing: 18
                BasicText {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: appInfo.appName + " " + appInfo.appVersion

                    font.pixelSize: 20
                    font.bold: true
                }
                BasicText {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Base on Qt " + appInfo.compilerVendor
                }
                BasicText {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Build on " + appInfo.buildDateTime
                }
                CusTextInput {
                    anchors.horizontalCenter: parent.horizontalCenter
                    readOnly: true
                    text: "From revision " + appInfo.buildRevision
                    font.underline: true
                }
                BasicText {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: appInfo.copyRight
                }
                BasicText {
                    anchors.horizontalCenter: parent.horizontalCenter
                    textFormat: Text.RichText

                    text: "Author JaredTao <a href=\"https://jaredtao.github.io\">JaredTao Blog</a>"
                    onLinkActivated: {
                        Qt.openUrlExternally("https://jaredtao.github.io")
                    }
                    TransArea {
                        cursorShape: Qt.PointingHandCursor
                    }
                }
            }

            Row {
                anchors {
                    bottom: closeBtn.top
                    bottomMargin: 4
                    horizontalCenter: parent.horizontalCenter
                }
                spacing: 20
                BasicText {
                    text: qsTr("Sponsors") + trans.transString
                    anchors.verticalCenter: parent.verticalCenter
                }
                CusImage {
                    source: imgPath + "Tao/weixin.jpg"

                }
                CusImage {
                    source: imgPath + "Tao/zhifubao.jpg"
                }
            }
        }
//        DropShadow {
//            anchors.fill: back
//            horizontalOffset: 0
//            verticalOffset: 0
//            radius: 8.0
//            samples: 16
//            color: "#ff007acc"
//            source: back
//        }
    }

    function show() {
        x = (parent.width - width) / 2
        y = (parent.height - height) / 2
        open()
    }
}
