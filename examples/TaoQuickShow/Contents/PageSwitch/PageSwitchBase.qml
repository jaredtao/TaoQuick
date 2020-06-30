import QtQuick 2.12
import QtQuick.Controls 2.12
import TaoQuick 1.0
import "qrc:/TaoQuick"

Item {
    id: base
    property int currentIndex: -1
    property int maxCount
    MouseArea {
        width: base.width / 2
        height: base.height
        onClicked: {
            if (currentIndex - 1 >= 0)
            {
                currentIndex--
            }
        }
    }
    MouseArea {
        x: base.width / 2
        width: base.width / 2
        height: base.height
        onClicked: {
            if (currentIndex + 1 < base.maxCount)
            {
                currentIndex++;
            }
        }
    }
    Component.onCompleted: {
        currentIndex = 0
    }
}

