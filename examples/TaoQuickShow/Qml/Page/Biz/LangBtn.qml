import QtQuick 2.12
import QtQuick.Controls 2.12
import TaoQuick 1.0
import "qrc:/TaoQuick"

TImageBtn {
    imageUrl: imgPath + (containsMouse ? "Window/lang_white.png" : "Window/lang_gray.png")
    onClicked: {
        //                notifyBox.notify("change language")
        pop.show()
    }
    TPopup {
        id: pop
        barColor: gConfig.reserverColor
        backgroundWidth: 100
        backgroundHeight: langListView.contentHeight > 500 ? 500 : langListView.contentHeight
        contentItem: ListView {
            id: langListView
            anchors.fill: parent
            anchors.margins: 2
            model: trans.languages
            clip: true
            delegate: TTextBtn {
                width: langListView.width
                height: 36
                text: trans.trans(modelData) + trans.transString
                color: trans.currentLang === modelData ? gConfig.titleBackground :( containsMouse ? "lightgray" : pop.barColor)
                textColor: gConfig.textColor
                onClicked: {
//                    pop.hide()
                    trans.setCurrentLang(modelData)
                }
            }
        }
    }
}
