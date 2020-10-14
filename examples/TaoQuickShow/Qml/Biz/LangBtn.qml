import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0


CusButton_Image {
    btnImgUrl: imgPath + (containsMouse ? "Window/lang_white.png" : "Window/lang_gray.png")
    tipText: qsTr("Language")
    onClicked: {
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
            delegate: CusButton {
                id: dBtn
                width: langListView.width
                height: 36
                text: qsTr(modelData) 
                backgroundColor: trans.currentLang === modelData ? gConfig.themeColor :( containsMouse ? "lightgray" : pop.barColor)
                textColor: gConfig.textColor
                borderWidth: 0
                radius: 4
                onClicked: {
//                    pop.hide()
                    trans.setCurrentLang(modelData)
                }
            }
        }
    }
}
