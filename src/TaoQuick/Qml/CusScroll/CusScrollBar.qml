import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

import ".."
import "../.."
ScrollBar {
    id: cusTirangleTipBorder
    property bool isSmaller: true
//    minimumSize: 0.1
//    size: Math.max(height / content.height, 0.1)
    contentItem: Rectangle {
        implicitWidth: isSmaller ?  CusConfig.scrollBarSize_Smaller : CusConfig.scrollBarSize
        implicitHeight: isSmaller ?  CusConfig.scrollBarSize_Smaller : CusConfig.scrollBarSize
        radius: CusConfig.scrollBarRadius
        color: isSmaller ? CusConfig.scrollBarBackgroundColor : CusConfig.scrollBarBackgroundColor_hovered
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
