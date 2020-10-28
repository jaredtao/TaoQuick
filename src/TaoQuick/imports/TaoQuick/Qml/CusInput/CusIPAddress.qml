import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."

Rectangle {
    implicitHeight: CusConfig.fixedHeight
    implicitWidth: defaultW * 4 + 2 * 3
    property int defaultW: 40
//    border.color: {
//        if (!enabled) {
//            return CusConfig.controlBorderColor_disabled
//        } else if (input1.focus || input2.focus || input3.focus || input4.focus) {
//            return CusConfig.controlBorderColor_pressed
//        } else if (transArea.containsMouse) {
//            return CusConfig.controlBorderColor_hovered
//        } else {
//            return CusConfig.controlBorderColor
//        }
//    }
    border.width: 1
    border.color: enabled && (transArea.containsMouse ||input1.focus || input2.focus || input3.focus || input4.focus) ? CusConfig.controlBorderColor_hovered : CusConfig.controlBorderColor
    radius: CusConfig.controlBorderRadius
    color: enabled ? CusConfig.controlColor : CusConfig.controlColor_disabled
    Row {
        anchors.fill: parent
        CusTextInput {
            id: input1
            width: defaultW
            validator: IntValidator{bottom: 1; top: 255;}

        }
        CusLabel {
            text: "."
            width: 2
        }
        CusTextInput {
            id: input2
            width: defaultW
            validator: IntValidator{bottom: 1; top: 255;}
        }
        CusLabel {
            text: "."
            width: 2
        }
        CusTextInput {
            id: input3
            width: defaultW
            validator: IntValidator{bottom: 1; top: 255;}
        }
        CusLabel {
            text: "."
            width: 2
        }
        CusTextInput {
            id: input4
            width: defaultW
            validator: IntValidator{bottom: 1; top: 255;}
        }
    }
    TransArea {
        id: transArea
        cursorShape: Qt.IBeamCursor
    }
}
