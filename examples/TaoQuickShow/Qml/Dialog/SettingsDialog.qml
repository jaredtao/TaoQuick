import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.9
import TaoQuick 1.0

Popup {
    id: root
    width: 600
    height: 340


    function showParentCenter() {
        x = (parent.width - width) / 2
        y = (parent.height - height) / 2
        open()
    }

    function showScreenCenter() {
        var globalX = (Screen.desktopAvailableWidth - width) / 2
        var globalY = (Screen.desktopAvailableHeight - height) / 2
        var pos = parent.mapFromGlobal(globalX, globalY)
        x = pos.x
        y = pos.y
        open()
    }
}
