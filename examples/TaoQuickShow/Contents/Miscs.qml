import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0

Item {
    anchors.fill: parent
    Column {
        anchors.centerIn: parent
        spacing: 10
        CusLabel {
            text: qsTr("BusyIndicator") + trans.transString
            wrapMode: Label.WordWrap
            width: 400
        }
        Row {
            spacing: 10
            CusBusyIndicator {
                width: 32
                height: 32
                busyRadius: 2
                busyCount: 3
                busyColor: "#008b8b"
            }
            CusBusyIndicator {
                width: 32
                height: 32
                busyRadius: 3
                busyCount: 4
                busyColor: Qt.darker("#008b8b", 1.2)
            }
            CusBusyIndicator {
                width: 64
                height: 64
                busyRadius: 4
                busyCount: 5
                busyColor: Qt.darker("#008b8b", 1.4)
            }
            CusBusyIndicator {
                width: 64
                height: 64
                busyRadius: 5
                busyCount: 6
                busyColor: Qt.darker("#008b8b", 1.6)
            }
        }
        Row {
            spacing: 10
            CusBusyIndicator {
                width: 32
                height: 32
                busyRadius: 2
                busyCount: 4
                busyColor: "#008b8b"
            }
            CusBusyIndicator {
                width: 64
                height: 64
                busyRadius: 4
                busyCount: 4
                busyColor: Qt.lighter("#008b8b", 1.2)
            }
            CusBusyIndicator {
                width: 96
                height: 96
                busyRadius: 10
                busyCount: 6
                busyColor: Qt.lighter("#008b8b", 1.4)
            }
            CusBusyIndicator {
                width: 128
                height: 128
                busyRadius: 12
                busyCount: 8
                busyColor: Qt.lighter("#008b8b", 1.6)
            }
        }
    }
}
