import QtQuick 2.12
import QtQuick.Controls 2.12
Item {
    TextArea {
        text: trans.trans("Welcome to the 'TaoQuick' demo program")  + trans.transString
        font.pixelSize: 20
        textFormat: TextEdit.RichText
        anchors.centerIn: parent
        width: parent.width
        readOnly: true
    }
}
