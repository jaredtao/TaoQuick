import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0

Item {
    anchors.fill: parent
    property color oneBusyColor: CusConfig.themeColor
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
                busyColor: oneBusyColor
            }
            CusBusyIndicator {
                width: 32
                height: 32
                busyRadius: 3
                busyCount: 4
                busyColor: Qt.darker(oneBusyColor, 1.2)
            }
            CusBusyIndicator {
                width: 64
                height: 64
                busyRadius: 4
                busyCount: 5
                busyColor: Qt.darker(oneBusyColor, 1.4)
            }
            CusBusyIndicator {
                width: 64
                height: 64
                busyRadius: 5
                busyCount: 6
                busyColor: Qt.darker(oneBusyColor, 1.6)
            }
        }
        Row {
            spacing: 10
            CusBusyIndicator {
                width: 32
                height: 32
                busyRadius: 2
                busyCount: 4
                busyColor: oneBusyColor
            }
            CusBusyIndicator {
                width: 64
                height: 64
                busyRadius: 4
                busyCount: 4
                busyColor: Qt.lighter(oneBusyColor, 1.2)
            }
            CusBusyIndicator {
                width: 96
                height: 96
                busyRadius: 10
                busyCount: 6
                busyColor: Qt.lighter(oneBusyColor, 1.4)
            }
            CusBusyIndicator {
                width: 128
                height: 128
                busyRadius: 12
                busyCount: 8
                busyColor: Qt.lighter(oneBusyColor, 1.6)
            }
        }
        Item {
            width: 1
            height: 20
        }
        CusLabel {
            text: qsTr("PageIndicator") + trans.transString
            wrapMode: Label.WordWrap
            width: 400
        }
        CusPageIndicator {
            count: 0
        }
        CusPageIndicator {
            count: 1
        }
        CusPageIndicator {
            count: 2
            currentIndex: 1
        }
        CusPageIndicator {
            count: 3
            currentIndex: 1
        }
        CusPageIndicator {
            count: 5
            currentIndex: 4
        }
        CusPageIndicator {
            count: 6
            currentIndex: 5
        }
        CusPageIndicator {
            count: 7
            currentIndex: 3
        }
        CusPageIndicator {
            count: 8
            currentIndex: 4
        }
        CusPageIndicator {
            count: 9
            currentIndex: 6
        }
        CusPageIndicator {
            count: 10
            currentIndex: 5
        }
        CusPageIndicator {
            count: 100
            currentIndex: 50
        }
    }
}
