import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
ToolTip {
    id: basicTooltip
    contentItem: BasicText {
        text: basicTooltip.text
        font.pixelSize: Config.tipTextPixel
        color: Config.tipTextColor
    }
    background: Rectangle {
        color: Config.tipBackgroundColor
        border.color: Config.tipBorderColor
    }
}
