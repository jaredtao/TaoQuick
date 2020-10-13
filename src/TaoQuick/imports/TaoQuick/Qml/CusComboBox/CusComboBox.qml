import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."

ComboBox {
    id: cusComboBox
    height: Config.fixedHeight
    leftPadding: 4
    rightPadding: 4
    currentIndex: 0
    readonly property string imgUrlNormal: Config.imagePathPrefix + "ComboBox_Down.png"
    readonly property string imgUrlHovered: Config.imagePathPrefix + "ComboBox_Down_Hover.png"

    property real defaultHeight: Config.fixedHeight * 6
    displayText: qsTr(currentText)
    background: Rectangle {
        color: cusComboBox.enabled ? Config.controlBackgroundColor : Config.controlBackgroundColor_disabled
        radius: Config.controlBorderRadius
        border.width: 1
        border.color: cusComboBox.focus
                      || cusComboBox.hovered ? Config.controlBorderColor_hovered : Config.controlBorderColor
    }
    contentItem: CusLabel {
        leftPadding: cusComboBox.leftPadding
        rightPadding: cusComboBox.indicator.width + cusComboBox.spacing
        text: cusComboBox.displayText
        font: cusComboBox.font
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        color: cusComboBox.enabled ? Config.textColor : Config.controlTextColor_disable
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
            TransArea {
                enabled: cusComboBox.enabled
            }
        }

        background: Rectangle {
            color: Config.controlBackgroundColor
            //            radius: Config.comboBoxBorderRadius
            border.width: 1
            border.color: Config.controlBorderColor
        }
    }
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
            color: cusComboBox.highlightedIndex
                   === index ? Config.controlTextColor_highlight : Config.textColor
        }
        highlighted: cusComboBox.highlightedIndex === index
        background: Rectangle {
            width: cusComboBox.width
            height: cusComboBox.height
            color: cusComboBox.highlightedIndex === index ? Config.controlBackgroundColor_highlight : (cusComboBox.currentIndex === index ? Config.controlBackgroundColor_hovered : Config.controlBackgroundColor)
        }
    }
}
