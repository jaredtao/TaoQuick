import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."
CusTextField {
    id: cusTextFieldBtn

    property Component rightBtn: nullptr

    background: Rectangle  {
        color: (cusTextFieldBtn.enabled && !cusTextFieldBtn.readOnly) ? Config.controlBackgroundColor : Config.controlBackgroundColor_disabled
        radius: Config.controlBorderRadius
        border.width: 1
        border.color: (cusTextFieldBtn.enabled && !cusTextFieldBtn.readOnly && (cusTextFieldBtn.hovered || cusTextFieldBtn.focus)) ? Config.controlBorderColor_hovered : Config.controlBorderColor

        Loader {
            sourceComponent: rightBtn
            anchors {
                right: parent.right
                rightMargin: 4
                verticalCenter: parent.verticalCenter
            }
        }
    }
}
