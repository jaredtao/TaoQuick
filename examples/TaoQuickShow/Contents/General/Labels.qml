import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0

Item {
    anchors.fill: parent
    Column {
        anchors.centerIn: parent
        spacing: 10
        CusLabel {
            text: qsTr("Hello, TaoQuick") + trans.transString
            wrapMode: Label.WordWrap
            width: 400
            font.pixelSize: 12
        }
        CusLabel {
            text: qsTr("Hello, TaoQuick") + trans.transString
            wrapMode: Label.WordWrap
            width: 400
            font.pixelSize: 14
        }
        CusLabel {
            text: qsTr("Hello, TaoQuick") + trans.transString
            wrapMode: Label.WordWrap
            width: 400
            font.pixelSize: 16
        }
        CusLabel {
            text: qsTr("Hello, TaoQuick") + trans.transString
            wrapMode: Label.WordWrap
            width: 400
            font.pixelSize: 18
        }
        CusLabel {
            text: qsTr("Hello, TaoQuick") + trans.transString
            wrapMode: Label.WordWrap
            width: 400
            font.pixelSize: 20
        }
    }
}
