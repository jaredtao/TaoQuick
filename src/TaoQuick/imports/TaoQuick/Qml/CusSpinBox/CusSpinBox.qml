import QtQuick 2.9
import QtQml 2.2
import QtQuick.Controls 2.9
import ".."
import "../.."
SpinBox {
    id: cusSpinBox
    height: CusConfig.fixedHeight
    implicitWidth: 60
    editable: true
    leftPadding: 4
    rightPadding: 4

    readonly property string imgUrlNormal : CusConfig.imagePathPrefix + "Expanded.png";
    readonly property string imgUrlHovered : CusConfig.imagePathPrefix + "Expanded_Hover.png";
    background: Rectangle {
        radius: CusConfig.controlBorderRadius
        color: CusConfig.controlColor
        border.width: 1
        border.color: cusSpinBox.hovered || cusSpinBox.focus ? CusConfig.controlBorderColor_hovered : CusConfig.controlBorderColor
    }
    contentItem: CusTextInput {
        id: input
        z: 2
//        text: cusSpinBox.value
        font: cusSpinBox.font
        color: CusConfig.textColor
        width: cusSpinBox.width - cusSpinBox.up.indicator.width - cusSpinBox.leftPadding - cusSpinBox.rightPadding
        selectionColor: CusConfig.controlColor_pressed
        selectedTextColor: CusConfig.textColor_pressed
        horizontalAlignment: Qt.AlignLeft
        verticalAlignment: Qt.AlignVCenter
//        onTextChanged: {
//            cusSpinBox.value = textFromValue(text)
//        }
        Binding {
            target: input
            property: "text"
            value: cusSpinBox.textFromValue(cusSpinBox.value, Qt.locale())
        }
        Binding{
            target: cusSpinBox
            property: "value"
            value: cusSpinBox.valueFromText(input.text, Qt.locale())
        }
        readOnly: !cusSpinBox.editable
        selectByMouse: true
        validator: cusSpinBox.validator
        inputMethodHints: Qt.ImhFormattedNumbersOnly
    }
    up.indicator: Item {
        x: cusSpinBox.width - width - cusSpinBox.rightPadding
        z: 3
        height: cusSpinBox.height / 2
        implicitWidth: 10
        implicitHeight: 10
        Image {
            anchors.centerIn: parent
            source: (upArea.hovered || upArea.pressed) ? imgUrlHovered : imgUrlNormal
            rotation: 180
        }
        MouseArea {
            id: upArea
            anchors.fill: parent
            hoverEnabled: true
            z: 5
            onClicked: {
                cusSpinBox.increase()
            }
        }
    }
    down.indicator: Item {
        x: cusSpinBox.width - width - cusSpinBox.rightPadding
        y: parent.height / 2
        z: 3
        height: cusSpinBox.height / 2
        implicitWidth: 10
        implicitHeight: 10
        Image {
            anchors.centerIn: parent
            source: (downArea.hovered || downArea.pressed) ? imgUrlHovered : imgUrlNormal
        }
        MouseArea {
            id: downArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                cusSpinBox.decrease()
            }
        }
    }
}