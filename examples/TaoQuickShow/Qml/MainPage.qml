import QtQuick 2.9
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
        id: titlePage
        width: rootView.width
        height: 60
        color: gConfig.themeColor
    }
    ContentPage {
        id: contentPage
        color: gConfig.background
        anchors {
            top: titlePage.bottom
            bottom: parent.bottom
            left: titlePage.left
            right: titlePage.right
        }
    }
    NotifyBox {
        id: notifyBox
    }
}
