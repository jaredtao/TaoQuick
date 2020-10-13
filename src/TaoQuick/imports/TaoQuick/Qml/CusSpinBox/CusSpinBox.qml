import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."
SpinBox {
    id: cusSpinBox
    height: Config.fixedHeight
    implicitWidth: 60
    editable: true
    leftPadding: 4
    rightPadding: 4

    readonly property string imgUrlNormal : Config.imagePathPrefix + "0_Common/Expanded.png";
    readonly property string imgUrlHovered : Config.imagePathPrefix + "0_Common/Expanded_Hover.png";
    background: Rectangle {
        radius: Config.controlBorderRadius
        color: Config.controlBackgroundColor
        border.width: 1
        border.color: cusSpinBox.hovered || cusSpinBox.focus ? Config.controlBorderColor_hovered : Config.controlBorderColor
    }
    contentItem: CusTextInput {
        id: input
        z: 2
//        text: cusSpinBox.value
        font: cusSpinBox.font
        color: Config.textColor
        width: cusSpinBox.width - cusSpinBox.up.indicator.width - cusSpinBox.leftPadding - cusSpinBox.rightPadding
        selectionColor: Config.controlBackgroundColor_highlight
        selectedTextColor: Config.controlTextColor_highlight
        horizontalAlignment: Qt.AlignLeft
        verticalAlignment: Qt.AlignVCenter
//        onTextChanged: {
//            cusSpinBox.value = textFromValue(text)
//        }
        Binding {
            target: input
            property: "text"
            value: cusSpinBox.textFromValue(cusSpinBox.value)
        }
        Binding{
            target: cusSpinBox
            property: "value"
            value: cusSpinBox.valueFromText(input.text)
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
