import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0

Item {
    anchors.fill: parent
    Column {
        anchors.centerIn: parent
        spacing: 10
        CusLabel {
            text: qsTr("General Button is consist of text, background and tooltip, it has normal, hover, pressed and disable states") + trans.transString
            wrapMode: Label.WordWrap
            width: 400
        }
        Row {
            spacing: 20
            CusButton {
                width: 120
                height: 30
                text: "Hello Button"
            }

            CusButton {
                width: 120
                height: 30
                text: "Button with tip"
                tipText: "Hello, i am tip"
            }
            CusButton {
                width: 120
                height: 30
                enabled: false
                text: "Disable Button"
            }
        }
        Item {
            width: 20
            height: 30
        }
        CusLabel {
            text: qsTr("Text Button has no background and border") + trans.transString
            wrapMode: Label.WordWrap
            width: 400
        }
        Row {
            spacing: 20
            CusTextButton {
                width: 120
                height: 30
                text: "Text Button"
                backgroundColor: "transparent"
                borderColor: "transparent"
            }
            CusTextButton {
                width: 120
                height: 30
                text: "Text Button with tip"
                tipText: "Hello, i am textButton tip"
                backgroundColor: "transparent"
                borderColor: "transparent"
            }
            CusTextButton {
                width: 120
                height: 30
                text: "Text Button"
                enabled: false
                backgroundColor: "transparent"
                borderColor: "transparent"
            }
        }
        Item {
            width: 20
            height: 30
        }
        CusLabel {
            text: qsTr("Material Button has a gradiant background when clicked") + trans.transString
            wrapMode: Label.WordWrap
            width: 400
        }
        Row {
            spacing: 20
            CusButton_Gradient {
                width: 120
                height: 30
                text: "Material Button"
            }
        }
        Item {
            width: 20
            height: 30
        }
        CusLabel {
            text: qsTr("Button can be design with different colors according to importance, example: blue for normal operation, red for danger operation and white for optional operation") + trans.transString
            wrapMode: Label.WordWrap
            width: 400
        }
        Row {
            spacing: 20

            CusButton_Blue {
                width: 120
                height: 30
                text: "Blue Button"
            }

            CusButton_Blue {
                width: 120
                height: 30
                text: "Button with tip"
                tipText: "i am blue button"
            }
            CusButton_Blue {
                width: 120
                height: 30
                text: "Blue Button"
                enabled: false
            }
        }
        Row {
            spacing: 20

            CusButton_White {
                width: 120
                height: 30
                text: "White Button"
            }

            CusButton_White {
                width: 120
                height: 30
                text: "Button with tip"
                tipText: "i am white button"
            }
            CusButton_White {
                width: 120
                height: 30
                text: "White Button"
                enabled: false
            }
        }
        Row {
            spacing: 20

            CusButton_Red {
                width: 120
                height: 30
                text: "Red Button"
            }

            CusButton_Red {
                width: 120
                height: 30
                text: "Button with tip"
                tipText: "i am red button"
            }
            CusButton_Red {
                width: 120
                height: 30
                text: "Red Button"
                enabled: false
            }
        }
    }
}
