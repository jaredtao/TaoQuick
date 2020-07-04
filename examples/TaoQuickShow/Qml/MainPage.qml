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
        width: rootView.width - 2
        height: 60
        color: gConfig.titleBackground
    }
    ContentPage {
        id: contentRect
        width: parent.width
        color: gConfig.background
        anchors.top: titleRect.bottom
        anchors.bottom: parent.bottom
    }
    NotifyBox {
        id: notifyBox
    }
}
