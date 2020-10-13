import QtQuick 2.9
import QtQuick.Controls 2.2
Item {
    width: 1024
    height: 768
    opacity: 1.0
    Behavior on opacity {
        NumberAnimation { duration: 500 }
    }
    TBusyIndicator {
        id: control
        running: true
        anchors.centerIn: parent
        width: 160
        height: 160
        durationPerCycle: 2000
    }
}
