import QtQuick 2.9

import TaoQuick 1.0


CusButton {
    id: root
    textColor: gConfig.textColor

    Image {
        anchors {
            right: parent.right
            rightMargin: 10
            verticalCenter: parent.verticalCenter
        }
        property string normalUrl:  imgPath + "Common/right.png"
        property string hoveredUrl: imgPath + "Common/right_hovered.png"
        source: (root.containsMouse || root.containsPress) ? hoveredUrl : normalUrl

    }

}

