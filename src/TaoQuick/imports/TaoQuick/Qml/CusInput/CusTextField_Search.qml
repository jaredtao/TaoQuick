import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."

CusTextField {
    id: cusSearch

    implicitWidth: 240
    height: Config.fixedHeight
    placeholderText: qsTr("Search")
    leftPadding: 36
    rightPadding: 30
    background: Rectangle {
        color: (cusSearch.enabled
                && !cusSearch.readOnly) ? Config.controlBackgroundColor : Config.controlBackgroundColor_disabled
        radius: Config.controlBorderRadius
        border.width: 1
        border.color: (cusSearch.enabled && !cusSearch.readOnly
                       && (cusSearch.hovered || cusSearch.focus)) ? Config.controlBorderColor_hovered : Config.controlBorderColor

        CusImage {
            id: icon
            anchors {
                left: parent.left
                leftMargin: 4
                verticalCenter: parent.verticalCenter
            }
            property string searchIconImg: Config.imagePathPrefix + "0_Common/Search.png"
            source: searchIconImg
        }
        Rectangle {
            width: 1
            y: 2
            height: parent.height - 2 * y
            x: icon.x + icon.width
            color: Config.controlBorderColor
        }
        CusButton_Image {
            z: 3
            anchors {
                right: parent.right
                rightMargin: 4
                verticalCenter: parent.verticalCenter
            }
            btnImgNormal: Config.isWhiteTheme ?  Config.imagePathPrefix + "0_Common/Search_Clear.png" : Config.imagePathPrefix + "B0_Common/Search_Clear.png"
            btnImgHovered: Config.isWhiteTheme ? Config.imagePathPrefix + "0_Common/Search_Clear_Hover.png" : Config.imagePathPrefix + "B0_Common/Search_Clear_Hover.png"
            btnImgPressed: btnImgHovered
            btnImgDisbaled: btnImgNormal
            onClicked: {
                cusSearch.clear()
            }
        }
    }
}
