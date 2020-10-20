import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0

Item {
    anchors.fill: parent
    Column {
        anchors.centerIn: parent
        spacing: 10
        CusLabel {
            text: qsTr("General Image") + trans.transString
            wrapMode: Label.WordWrap
            width: 400
        }
        CusImage {
            width: 225
            height: 150
            source: imgPath + "Effect/baby.jpg"
        }
        Item {
            width: 10
            height: 30
        }
        CusLabel {
            text: qsTr("Image with tip") + trans.transString
            wrapMode: Label.WordWrap
            width: 400
        }
        CusImage_Tip {
            width: 450
            height: 300
            source: imgPath + "Effect/girl.jpg"
            tipText: "i am Image tip"
        }
    }
}
