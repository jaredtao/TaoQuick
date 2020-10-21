import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0

Item {
    id: base
    property int currentIndex: -1
    property var images
    property int maxCount: images.length
    property var dirs
    property int dir: -1
    Component.onCompleted: {
        currentIndex = 0
        dir = 0
    }
    Column {
        anchors {
            left: parent.left
            bottom: parent.bottom
            margins: 10
        }
        CusSwitch {
            id: autoPlaySwitch
            text: qsTr("Auto Play") + trans.transString
            checked: true
        }
        CusComboBox {
            model: dirs
            visible: count > 0
            currentIndex: base.currentDir
            implicitWidth: 180
            onCurrentIndexChanged: {
                if (base.dir !== currentIndex) {
                    base.dir = currentIndex
                }
            }
        }
    }
    Timer {
        id: autoPlayTimer
        interval: 2800
        running: autoPlaySwitch.checked
        repeat: true
        property bool reserve: false
        triggeredOnStart: true
        onTriggered: {
            if (reserve) {
                base.currentIndex--
            } else {
                base.currentIndex++
            }
            if (base.currentIndex >= images.length - 1) {
                reserve = true
            } else if (base.currentIndex <= 0) {
                reserve = false
            }
        }
    }
}
