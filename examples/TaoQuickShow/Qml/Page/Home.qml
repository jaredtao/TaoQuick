import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0
Item {
    anchors.centerIn: parent
    CusLabel {
        text: qsTr("TaoQuick provides a set of controls that can be used to build complete interfaces in Qt Quick.") + trans.transString
        horizontalAlignment: Label.AlignHCenter
        verticalAlignment: Label.AlignVCenter
        wrapMode: Label.Wrap
        anchors.centerIn: parent
    }
}
