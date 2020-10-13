import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."
Slider {
    id: cusSlider
    implicitWidth: 200
    height: Config.fixedHeight
    property bool showNumber: false
    background: Rectangle {
        x: cusSlider.leftPadding
        y: cusSlider.topPadding + cusSlider.availableHeight / 2 - height /2
        implicitHeight: 4
        width: cusSlider.availableWidth
        height: implicitHeight
        radius: Config.controlBorderRadius
        color: Config.controlBorderColor
        Rectangle {
            width: cusSlider.visualPosition * parent.width
            height: parent.height
            color: Config.controlBorderColor_hovered
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
        color: handleArea.handlePressed ? Config.controlBackgroundColor_highlight : (handleArea.handleHovered ? Config.controlBackgroundColor_hovered : Config.controlBackgroundColor)
        border.color: (handleArea.handleHovered || handleArea.handlePressed || handleArea.focus) ? Config.controlBorderColor_hovered : Config.controlBorderColor
        border.width: 1
        CusLabel {
            visible: showNumber
            anchors.centerIn: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            text: parseInt(cusSlider.value)
            color: (handleArea.handleHovered || handleArea.handlePressed) ? Config.controlTextColor_highlight : Config.textColor
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
