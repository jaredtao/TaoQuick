import QtQuick 2.9
import QtQuick.Controls 2.2
import "./Effects"

import TaoQuick 1.0

Item {
    anchors.fill: parent
    Rectangle {
        id: textRect
        width: 400
        height: 300
        anchors.centerIn: parent
        color: Qt.rgba(0.1, 0.2, 0.3)

        TextEdit {
            id: textArea
            anchors {
                fill: parent
                margins: 10
            }
            width: parent.width - 20
            selectByMouse: true
            color: "red"
            font.pixelSize: 16
            onTextChanged: {
                if (text.length > 0) {
                    atomJoggle.joggle(100, 4)
                }
            }
            AtomJoggle {
                id: atomJoggle
                anchors.fill: parent
                targetWin: view
                targetEdit: textArea
            }
        }
    }
    CusLabel {
        text: qsTr("Input on above rect to try Atom-Joggle effect")
        anchors {
            top: textRect.bottom
            topMargin: 10
            horizontalCenter: parent.horizontalCenter
        }
    }

}

