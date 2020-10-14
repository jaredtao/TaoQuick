import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0
import "./Page"

Item {
    id: rootItem
    width: 1440
    height: 900

    ContentData {
        id: gConfig
        objectName: "gConfig"
    }
    AboutDialog {
        id: aboutDialog
    }
    TitlePage {
        id: title
        width: parent.width
        height: 60
        color: gConfig.themeColor
    }
    NotifyBox {
        id: notifyBox
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
    }
}
