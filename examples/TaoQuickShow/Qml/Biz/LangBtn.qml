import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0

CusButton_Image {
    btnImgUrl: imgPath + (hovered
                          || pressed ? "Window/lang_white.png" : "Window/lang_gray.png")
    tipText: qsTr("Language") + trans.transString
    onClicked: {
        pop.show()
    }
    CusPopup {
        id: pop
        barColor: CusConfig.controlColor
        backgroundWidth: 100
        backgroundHeight: langListView.contentHeight > 500 ? 500 : langListView.contentHeight + 2
        contentItem: ListView {
            id: langListView
            anchors.fill: parent
            anchors.margins: 2
            model: trans.languages
            interactive: false
            clip: true
            delegate: Item {
                width: langListView.width
                height: 36
                CusButton {
                    id: dBtn
                    anchors {
                        fill: parent
                        margins: 4
                    }
                    text: modelData
                    backgroundColor: trans.currentLang === modelData ? CusConfig.controlColor_pressed : (hovered || pressed ? CusConfig.controlColor_hovered : pop.barColor)
                    textColor: CusConfig.textColor
                    borderWidth: 0
                    radius: 4
                    onClicked: {
                        trans.setCurrentLang(modelData)
                    }
                }
            }
        }
    }
}
