import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."

CusTextField {
    id: cusSearch

    implicitWidth: 240
    height: CusConfig.fixedHeight

    leftPadding: 36
    rightPadding: 30
    background: Rectangle {
        color: (cusSearch.enabled
                && !cusSearch.readOnly) ? CusConfig.controlColor : CusConfig.controlColor_disabled
        radius: CusConfig.controlBorderRadius
        border.width: 1
        border.color: (cusSearch.enabled && !cusSearch.readOnly
                       && (cusSearch.hovered
                           || cusSearch.focus)) ? CusConfig.controlBorderColor_hovered : CusConfig.controlBorderColor

        CusImage {
            id: icon
            anchors {
                left: parent.left
                leftMargin: 4
                verticalCenter: parent.verticalCenter
            }
            property string searchIconImg: CusConfig.imagePathPrefix + "Search.png"
            source: searchIconImg
        }
        Rectangle {
            width: 1
            y: 2
            height: parent.height - 2 * y
            x: icon.x + icon.width
            color: CusConfig.controlBorderColor
        }
        CusButton_ImageColorOverlay {
            z: 3
            anchors {
                right: parent.right
                rightMargin: 4
                verticalCenter: parent.verticalCenter
            }
            visible: cusSearch.text.length > 0
            btnImgNormal: CusConfig.imagePathPrefix + "Search_Clear.png"

            onClicked: {
                cusSearch.clear()
            }
        }
    }
}
