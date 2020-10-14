import QtQuick 2.9

import TaoQuick 1.0


TTextBtn {
    id: root
    textColor: gConfig.textColor
    textItem.font.pixelSize: gConfig.fontPixel
    textItem.font.family:  gConfig.fontFamily

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

