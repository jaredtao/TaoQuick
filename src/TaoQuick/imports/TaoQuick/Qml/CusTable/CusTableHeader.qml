import QtQuick 2.9
import QtQuick.Controls 2.2
import "."
import ".."
import "../.."

Item {
    id: cusTableHeader
    height: CusConfig.fixedHeight
    clip: true

    property int splitingIndex: -1
    property bool isOut: false
    property var dataObj
    property var headerRoles
    property var headerNames
    property bool needSort: true

    property var widthList
    property var xList
    property real totalW

    onWidthListChanged: {
        updateXList()
    }
    onWidthChanged: {
        updateWidthList()
        updateXList()
    }
    Component.onCompleted: {
        updateWidthList()
        updateXList()
    }
    property var updateXList: function() {
        var xL = [0]
        var tw = 0;
        for (var i = 0; i < widthList.length; ++i) {
            xL.push(xL[i] + widthList[i])
            tw += widthList[i]
        }
        xList = xL
        totalW = tw
    }
    property var updateWidthList: function () {}

    Rectangle {
        id: header0
        color: CusConfig.controlColor
        width: widthList[0]
        height: CusConfig.fixedHeight
        visible: width > 0
        CusCheckBox {
            id: checkAllBox
            anchors.verticalCenter: parent.verticalCenter
            x: 6
            height: 20
            width: height
            indicator.width: 20
            indicator.height: 20
            property bool notify: true
            onCheckedChanged: {
                if (notify) {
                    dataObj.setAllChecked(checked)
                }
            }
            Connections {
                target: dataObj
                onAllCheckedChanged: {
                    checkAllBox.notify = false
                    checkAllBox.checked = allChecked
                    checkAllBox.notify = true
                }
            }
        }
    }
    Repeater {
        model: headerRoles
        Rectangle {
            x: xList[index + 1]
            height: CusConfig.fixedHeight
            width: widthList[index + 1]
            color: CusConfig.controlColor
            CusLabel {
                anchors.fill: parent
                text: qsTr(headerNames[index]) + CusConfig.transString
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: CusConfig.textColor_pressed
            }
            Rectangle {
                width: 1
                anchors {
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                    topMargin: 2
                    bottomMargin: 2
                }
                color: (moveArea.pressed
                        || moveArea.containsMouse) ? CusConfig.controlBorderColor_pressed : CusConfig.controlBorderColor
            }
            CusImageOverlay {
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top
                }
                width: 8
                height: 8
                readonly property string ascUrl: CusConfig.imagePathPrefix + "Table_Asc.png"
                readonly property string ascUrl_Hovered: CusConfig.imagePathPrefix
                                                         + "Table_Asc_Hovered.png"
                readonly property string descUrl: CusConfig.imagePathPrefix + "Table_Desc.png"
                readonly property string descUrl_Hovered: CusConfig.imagePathPrefix
                                                          + "Table_Desc_Hovered.png"

                property string ascImageUrl: (headerArea.containsMouse) ? ascUrl_Hovered : ascUrl
                property string descImageUrl: (headerArea.containsMouse) ? descUrl_Hovered : descUrl

                source: visible ? (dataObj.sortOrder === 0 ? ascImageUrl : descImageUrl) : ""

                visible: dataObj && dataObj.sortRole === headerRoles[index]
                color: headerArea.containsMouse ? CusConfig.imageColor_hovered : CusConfig.imageColor
            }
            MouseArea {
                id: headerArea
                hoverEnabled: true
                anchors {
                    left: parent.left
                    leftMargin: 2
                    right: parent.right
                    top: parent.top
                    bottom: parent.bottom
                }
                onClicked: {
                    if (dataObj.sortRole !== headerRoles[index]) {
                        dataObj.sortRole = headerRoles[index]
                    } else {
                        if (dataObj.sortOrder === Qt.AscendingOrder) {
                            dataObj.sortOrder = Qt.DescendingOrder
                        } else {
                            dataObj.sortOrder = Qt.AscendingOrder
                        }
                    }
                    dataObj.sortByRole()
                }
            }
            MoveArea {
                id: moveArea
                width: 2
                height: parent.height
                enabled: index > 0
                hoverEnabled: true
                z: 9
                anchors {
                    left: parent.left
                }
                onPressedChanged: {
                    if (pressed) {
                        splitingIndex = index
                    } else {
                        splitingIndex = -1
                    }
                }
                cursorShape: (pressed || containsMouse) ? Qt.SplitHCursor : Qt.ArrowCursor
                onMove: {
                    var wList = widthList
                    if (index === 0) {
                        return
                    }
                    if (CusTableConstant.minWidth <= wList[index] + xOffset && wList[index] + xOffset <= CusTableConstant.maxWidth ) {
                        isOut = false
                        wList[index] += xOffset
                        widthList = wList
                    } else {
                        isOut = true
                    }
                }
            }
        }
    }
}
