import QtQuick 2.9

import TaoQuick 1.0

CusButton_Image {
    width: 48
    height: 48

    btnImgUrl: imgPath + (hovered || pressed ? "Common/left_hovered.png" : "Common/left.png")
}
