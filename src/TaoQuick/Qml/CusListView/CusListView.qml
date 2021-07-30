import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."

ListView {
    id: cusListView

    signal pressed(real mouseX, real mouseY)
    signal released()
    signal positionChanged(real mouseX, real mouseY)
    signal doubleClicked(real mouseX, real mouseY)

    focus: true
    clip: true
    interactive: false
    snapMode: ListView.SnapToItem
    cacheBuffer: 12000
    property string noDataText: qsTr("No Data") + CusConfig.transString

    ScrollBar.horizontal: CusScrollBar {
        id: hbar
        opacity: cusListView.contentWidth > cusListView.width ? 1.0 : 0.0
        visible: opacity > 0
        active: visible
    }
    ScrollBar.vertical: CusScrollBar {
        id: vBar
        opacity: cusListView.contentHeight > cusListView.height ? 1.0 : 0.0
        visible: opacity > 0
        active: visible
    }
    CusShortCutKeys {
        id: tableKeys
        onSelectAllPressed: {
            cusListView.model.selectAll()
        }
        onEscPressed: {
            cusListView.model.deselectAll()
        }
    }
    Keys.enabled: true
    Keys.onPressed: {
        switch (event.key) {
        case Qt.Key_Control:
            tableKeys.ctrlPressed = true
            break
        case Qt.Key_Shift:
            tableKeys.shiftPressed = true
            break
        case Qt.Key_Escape:
            tableKeys.escPressed()
            break
        case Qt.Key_A:
            if (tableKeys.ctrlPressed) {
                tableKeys.selectAllPressed()
            }
            break
        default:
            break
        }
    }
    Keys.onReleased: {
        switch (event.key) {
        case Qt.Key_Control:
            tableKeys.ctrlPressed = false
            break
        case Qt.Key_Shift:
            tableKeys.shiftPressed = false
            break
        case Qt.Key_Escape:
            tableKeys.escReleased()
            break
        case Qt.Key_A:
            if (tableKeys.ctrlPressed) {
                tableKeys.selectAllReleased()
            }
            break
        default:
            break
        }
    }
    //Qt 5.9 not support, need 5.10 or grater
    //    Shortcut {
    //        sequence: StandardKey.SelectAll
    //        onActivated: {
    //            cusListView.model.selectAll()
    //        }
    //    }
    //    Shortcut {
    //        sequence: StandardKey.Cancel
    //        onActivated: {
    //            cusListView.model.deselectAll()
    //        }
    //    }
    highlightFollowsCurrentItem: false
    add: null
    addDisplaced: null
    displaced: null
    move: null
    moveDisplaced: null
    remove: null
    removeDisplaced: null
    populate: null
    BasicText {
        text: noDataText
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 10
        }
        visible: cusListView.count <= 0
    }
    TransArea {
        anchors.fill: parent
        onWheel: {
            //angle
            if (vBar.visible) {
                if (wheel.angleDelta.y > 0) {
                    vBar.decrease()
                } else if (wheel.angleDelta.y < 0) {
                    vBar.increase()
                }
            }
        }
    }
}
