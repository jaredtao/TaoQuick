import QtQuick 2.12

import TaoQuick 1.0
import "qrc:/TaoQuick"
TImageBtn {
    width: 20
    height: 20

    imageUrl: imgPath + (containsMouse ? "Window/close_white.png" : "Window/close_gray.png")
}
