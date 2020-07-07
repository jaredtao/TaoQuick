import QtQuick 2.12
import "./Page"

import TaoQuick 1.0
import "qrc:/TaoQuick"

Item {
    anchors.fill: parent
    ContentData {
        id: gConfig
        objectName: "gConfig"
    }
    AboutDialog {
        id: aboutDialog
    }
    TitlePage {
        id: titleRect
        width: rootView.width
        height: 60
        color: gConfig.themeColor
    }
    ContentPage {
        id: contentRect
        color: gConfig.background
        anchors {
            top: titleRect.bottom
            bottom: parent.bottom
            left: titleRect.left
            right: titleRect.right
        }
    }
    NotifyBox {
        id: notifyBox
    }
}
