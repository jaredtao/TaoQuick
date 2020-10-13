import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
CusLabel {
    font.pixelSize: Config.fontSize_h3
    leftPadding: 4
    verticalAlignment: Text.AlignVCenter
    Rectangle
    {
        width: 2
        height: parent.height * 0.75
        color: Config.borderColor
        anchors
        {
            left: parent.left
            verticalCenter: parent.verticalCenter
        }
    }
}
