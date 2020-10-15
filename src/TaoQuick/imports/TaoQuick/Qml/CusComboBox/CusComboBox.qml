import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."

ComboBox {
    id: cusComboBox
    height: CusConfig.fixedHeight
    leftPadding: 4
    rightPadding: 4
    currentIndex: 0
    readonly property string imgUrlNormal: CusConfig.imagePathPrefix + "ComboBox_Down.png"
    readonly property string imgUrlHovered: CusConfig.imagePathPrefix + "ComboBox_Down_Hover.png"

    property real defaultHeight: CusConfig.fixedHeight * 6
    displayText: qsTr(currentText)
    background: Rectangle {
        color: cusComboBox.enabled ? CusConfig.controlColor : CusConfig.controlColor_disabled
        radius: CusConfig.controlBorderRadius
        border.width: 1
        border.color: cusComboBox.focus
                      || cusComboBox.hovered ? CusConfig.controlBorderColor_hovered : CusConfig.controlBorderColor
    }
    contentItem: CusLabel {
        leftPadding: cusComboBox.leftPadding
        rightPadding: cusComboBox.indicator.width + cusComboBox.spacing
        text: cusComboBox.displayText
        font: cusComboBox.font
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        color: cusComboBox.enabled ? CusConfig.textColor : CusConfig.textColor_disabled
        TransArea {
            enabled: cusComboBox.enabled
        }
    }
    indicator: Image {
        x: cusComboBox.width - width - cusComboBox.rightPadding
        y: cusComboBox.topPadding + (cusComboBox.availableHeight - height) / 2
        width: sourceSize.width
        height: sourceSize.height

        source: cusComboBox.hovered ? imgUrlHovered : imgUrlNormal
        rotation: cusComboBox.popup.visible ? 180 : 0
        Behavior on rotation {
            NumberAnimation {
                duration: 200
            }
        }
    }

    popup: Popup {
        y: cusComboBox.height - 1
        width: cusComboBox.width
        implicitHeight: Math.min(contentItem.implicitHeight, defaultHeight)
        height: visible ? implicitHeight : 0
        Behavior on height {
            NumberAnimation {
                duration: 200
            }
        }
        padding: 1

        contentItem: ListView {
            id: list
            clip: true
            implicitHeight: contentHeight
            model: cusComboBox.popup.visible ? cusComboBox.delegateModel : null
            currentIndex: cusComboBox.highlightedIndex
            ScrollBar.vertical: CusScrollBar {
                policy: (cusComboBox.popup.height
                         >= cusComboBox.defaultHeight) ? ScrollBar.AlwaysOn : ScrollBar.AsNeeded
            }
        }

        background: Rectangle {
            color: CusConfig.controlColor
//            radius: CusConfig.controlBorderRadius
            border.width: 1
            border.color: CusConfig.controlBorderColor
        }
    }
    property int hoveredIndex: -1
    delegate: ItemDelegate {
        width: cusComboBox.width
        height: cusComboBox.height
        contentItem: CusLabel {
            leftPadding: cusComboBox.leftPadding
            rightPadding: cusComboBox.indicator.width + cusComboBox.spacing
            text: qsTr(String(modelData))
            font: cusComboBox.font
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
            color: cusComboBox.hoveredIndex
                   === index ? CusConfig.textColor_pressed : CusConfig.textColor
        }
        highlighted: cusComboBox.hoveredIndex === index
        background: Rectangle {
            width: cusComboBox.width
            height: cusComboBox.height
            color: cusComboBox.hoveredIndex === index ? CusConfig.controlColor_hovered : (cusComboBox.currentIndex === index ? CusConfig.controlColor_pressed : CusConfig.controlColor)
        }
        TransArea {
            enabled: cusComboBox.enabled
            onContainsMouseChanged: {
                if (containsMouse) {
                    cusComboBox.hoveredIndex = index
                } else {
                    cusComboBox.hoveredIndex = -1
                }
            }
        }
    }
}
