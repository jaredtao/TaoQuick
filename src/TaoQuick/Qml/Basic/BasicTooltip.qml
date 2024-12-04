import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import ".."
import "../.."
ToolTip {
    id: basicTooltip
    contentItem: BasicText {
        text: basicTooltip.text
    }
    background: Rectangle {
        color: CusConfig.tipBackgroundColor
        border.color: CusConfig.tipBorderColor
    }
}
