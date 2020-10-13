import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."
ScrollBar {
    id: cusTirangleTipBorder
    property bool isSmaller: true
    contentItem: Rectangle {
        implicitWidth: isSmaller ?  Config.scrollBarSize_Smaller : Config.scrollBarSize
        implicitHeight: isSmaller ?  Config.scrollBarSize_Smaller : Config.scrollBarSize
        radius: Config.scrollBarRadius
        color: Config.scrollBarBackgroundColor
        TransArea{
            id: t
            onEntered: {
                isSmaller = false
            }
            onExited: {
                isSmaller = true
            }
        }
    }
}
