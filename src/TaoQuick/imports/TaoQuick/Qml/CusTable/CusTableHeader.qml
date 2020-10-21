import QtQuick 2.9
import QtQuick.Controls 2.2
import "."
import ".."
import "../.."

Item {
    id: deviceAddHeader
    height: CusConfig.fixedHeight
    property bool isSpliting: false
    property bool isOut: false
    property real mouseX
    property var dataObj
    property var headerRoles
    property var headerNames
    clip: true
    //表头宽度要平均处理的数量
    property int averageCount: 5
    //表头平均处理的宽度占比（不包含0列checkbox宽度）
    property real averageSize: 0.7
    property var widthList: [CusTableConstant.column0Width]
    property var xList: [0]
    onWidthListChanged: {
        var xL = [0]
        for (var i = 0; i < widthList.length; ++i) {
            xL.push(xL[i] + widthList[i])
        }
        xList = xL
    }
    onWidthChanged: {
        updateWidthList()
    }
    Component.onCompleted: {
        updateWidthList()
    }
    function updateWidthList() {
        var wL = [CusTableConstant.column0Width]
        //实际可以平均处理的数量
        var count = Math.min(averageCount, headerRoles.length)
        if (count <= 0) {
            return
        }
        //剩下的数量
        var leftCount = headerRoles.length - count
        //有效宽度
        var avalidWidth = width - CusTableConstant.column0Width
        //平均宽度
        var averageWidth = (avalidWidth * averageSize) / count
        averageWidth = CusTableConstant.bound(CusTableConstant.minWidth,
                                              averageWidth,
                                              CusTableConstant.maxWidth)
        //剩下的宽度
        var leftWidth = 0
        if (leftCount > 0) {
            leftWidth = (avalidWidth - averageWidth * count) / leftCount
        }
        for (var i = 0; i < headerRoles.length; ++i) {
            if (i < count) {
                wL.push(averageWidth)
            } else {
                wL.push(leftWidth)
            }
        }
        widthList = wL
    }
    Rectangle {
        id: header0
        color: CusConfig.controlColor
        width: widthList[0]
        height: CusConfig.fixedHeight
        CusCheckBox {
            id: checkAllBox
            anchors.centerIn: parent
            height: CusConfig.fixedHeight
            width: height
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
                text: qsTr(headerNames[index])
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
            CusImage {
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top
                }
                readonly property string ascUrl: CusConfig.imagePathPrefix + "Table_Asc.png"
                readonly property string ascUrl_Hovered: CusConfig.imagePathPrefix + "Table_Asc_Hover.png"
                readonly property string descUrl: CusConfig.imagePathPrefix + "Table_Desc.png"
                readonly property string descUrl_Hovered: CusConfig.imagePathPrefix + "Table_DescHover.png"

                property string ascImageUrl: (headerArea.containsMouse) ? ascUrl_Hovered : ascUrl
                property string descImageUrl: (headerArea.containsMouse) ? descUrl_Hovered : descUrl

                source: visible ? (dataObj.sortOrder === 0 ? ascImageUrl : descImageUrl) : ""

                visible: dataObj && dataObj.sortRole === headerRoles[index]
            }
            MouseArea {
                id: headerArea
                hoverEnabled: true
                anchors {
                    fill: parent
                    leftMargin: 4
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
                width: 4
                height: parent.height
                enabled: index > 0
                anchors {
                    left: parent.left
                }
                onMouseXChanged: {
                    deviceAddHeader.mouseX = mapToItem(deviceAddHeader,
                                                       mouseX, 0).x
                }
                onPressedChanged: {
                    if (pressed) {
                        isSpliting = true
                    } else {
                        isSpliting = false
                    }
                }
                cursorShape: (pressed
                              || containsMouse) ? Qt.SplitHCursor : Qt.ArrowCursor
                onMove: {
                    var wList = widthList
                    if (index === 0) {
                        return
                    }
                    if (CusTableConstant.minWidth <= wList[index] + xOffset
                            && wList[index] + xOffset
                            <= CusTableConstant.maxWidth && CusTableConstant.minWidth
                            <= wList[index + 1] - xOffset && wList[index + 1] - xOffset
                            <= CusTableConstant.maxWidth) {
                        isOut = false
                        wList[index] += xOffset
                        wList[index + 1] -= xOffset
                        widthList = wList
                    } else {
                        isOut = true
                    }
                }
            }
        }
    }
}
