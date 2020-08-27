import QtQuick 2.12
import QtQuick.Controls 2.12

import TaoQuick 1.0
import "qrc:/TaoQuick"

Popup {
    id: root
    width: 600
    height: 340

    background: Rectangle {
        id: back
        width: root.width
        height: root.height
        radius: 8
        color: gConfig.themeColor
        border.width: 1
        border.color: gConfig.reserverColor
        TMoveArea {
            anchors.fill: parent
            control: root
        }
        Image {
            id: img
            anchors.left: parent.left
            anchors.leftMargin: 2
            anchors.verticalCenter: parent.verticalCenter
            source: imgPath + "logo/milk.png"
        }
        TTextBtn {
            id: closeBtn
            text: qsTr("Close") 
            width: 80
            height: 38
            radius: 8
            color: containsPress ? Qt.darker(gConfig.background, 1.2) : (containsMouse ? Qt.lighter(gConfig.background, 1.2) : gConfig.background)
            textColor: gConfig.textColor
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
            anchors.right: parent.right
            spacing: 18
            Text {
                anchors.left: parent.left
                anchors.right: parent.right
                text: appInfo.appName + " " + appInfo.appVersion

                font.pixelSize: 20
                renderType: Text.NativeRendering
            }
            Text {
                anchors.left: parent.left
                anchors.right: parent.right
                wrapMode: Text.WordWrap
                text: "Base on Qt " + appInfo.compilerVendor
                font.pixelSize: 16
                renderType: Text.NativeRendering
            }
            Text {
                anchors.left: parent.left
                anchors.right: parent.right
                text: "Build on " + appInfo.buildDateTime
                font.pixelSize: 16
                renderType: Text.NativeRendering
            }
            TextInput {
                anchors.left: parent.left
                anchors.right: parent.right
                readOnly: true
                selectByMouse: true
                text: "From revision " + appInfo.buildRevision
                font.pixelSize: 16
                font.underline: true
                renderType: Text.NativeRendering
            }
            Text {
                anchors.left: parent.left
                anchors.right: parent.right
                text: appInfo.copyRight
                font.pixelSize: 16
                renderType: Text.NativeRendering
            }
            Text {
                anchors.left: parent.left
                anchors.right: parent.right
                textFormat: Text.RichText

                text: "Author JaredTao <a href=\"https://jaredtao.github.io\">JaredTao Blog</a>"
                onLinkActivated: {
                    Qt.openUrlExternally("https://jaredtao.github.io")
                }
                font.pixelSize: 16
                renderType: Text.NativeRendering
            }
            TextArea {
                readOnly: true
                anchors.left: parent.left
                anchors.right: parent.right
                text: appInfo.descript
                font.pixelSize: 16
                renderType: Text.NativeRendering
            }
        }
    }

    function show()
    {
        x = (parent.width - width) / 2
        y = (parent.height - height) / 2
        open()
    }

}
