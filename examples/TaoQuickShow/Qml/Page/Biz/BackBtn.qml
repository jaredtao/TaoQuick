import QtQuick 2.9

import TaoQuick 1.0
import "qrc:/TaoQuick"
TImageBtn {
    width: 48
    height: 48

    imageUrl: imgPath + (containsMouse ? "Common/left_hovered.png" : "Common/left.png")
}
