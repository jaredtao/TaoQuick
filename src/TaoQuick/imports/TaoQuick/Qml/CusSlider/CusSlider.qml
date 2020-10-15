import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."
Slider {
    id: cusSlider
    implicitWidth: 200
    height: CusConfig.fixedHeight
    property bool showNumber: true
    background: Rectangle {
        x: cusSlider.leftPadding
        y: cusSlider.topPadding + cusSlider.availableHeight / 2 - height /2
        implicitHeight: 4
        width: cusSlider.availableWidth
        height: implicitHeight
        radius: CusConfig.controlBorderRadius
        color: CusConfig.controlBorderColor
        Rectangle {
            width: cusSlider.visualPosition * parent.width
            height: parent.height
            color: CusConfig.controlBorderColor_hovered
            radius: parent.radius
        }
    }
    handle: Rectangle {
        x: cusSlider.leftPadding + cusSlider.visualPosition * (cusSlider.availableWidth - width)
        y: cusSlider.topPadding + cusSlider.availableHeight / 2 - height / 2
        property bool handleHovered: cusSlider.hovered
        implicitWidth: showNumber ? 24 : 16
        implicitHeight: implicitWidth
        radius: width / 2
        color: handleArea.handlePressed ? CusConfig.controlColor_pressed : (handleArea.handleHovered ? CusConfig.controlColor_hovered : CusConfig.controlColor)
        border.color: (handleArea.handleHovered || handleArea.handlePressed || handleArea.focus) ? CusConfig.controlBorderColor_hovered : CusConfig.controlBorderColor
        border.width: 1
        CusLabel {
            visible: showNumber
            anchors.centerIn: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            text: parseInt(cusSlider.value)
            color: (handleArea.handleHovered || handleArea.handlePressed) ? CusConfig.textColor_pressed : CusConfig.textColor
        }
        TransArea {
            id: handleArea

            property bool handleHovered: false
            property bool handlePressed: handleHovered && cusSlider.pressed
            onEntered: {
                handleHovered = true;
            }
            onExited: {
                handleHovered = false;
            }
        }
    }
}
