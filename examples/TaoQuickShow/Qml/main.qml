import QtQuick 2.9
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0
import TaoQuick 1.0
import "./Page"

Item {
    id: rootItem
    width: 1440
    height: 900
    ContentData {
        id: gConfig
    }

    TitlePage {
        id: title
        width: parent.width
        height: 60
        color: gConfig.themeColor
    }
    Rectangle {
        id: content
        width: parent.width
        anchors {
            top: title.bottom
            bottom: parent.bottom
        }
        color: gConfig.background
        TFPS {
            anchors {
                right: parent.right
                top: parent.top
            }
        }
        CusButton_Blue {
            text: qsTr("hello")
            x: 80
            y: 200
            width: 120
            height: 30
        }
        CusButton_Blue {
            anchors.centerIn: parent
            text: qsTr("Chinese")
        }
    }

    DropShadow {
        source: rootItem
        radius: 8
        color: "#007acc"
    }
}
