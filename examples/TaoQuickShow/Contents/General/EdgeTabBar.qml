import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0

Item {
    anchors.fill: parent
    property int tabHeight: 44

    Rectangle {
        x: 50
        y: 90
        width: 800
        height: 600
        border.color: "gray"
        border.width: 1
        color: "#f7f7f7"

        Item {
            id: chromeTabItem
            height: 50
            width: parent.width
            clip: true
            CusRoundTabButton {
                id: leftBtn
                width: 50
                height: tabHeight
                color: "#2d7d9a"
                CusImage {
                    anchors {
                        left: parent.left
                        leftMargin: 10
                        verticalCenter: parent.verticalCenter
                    }
                    source: imgPath + "logo/milk_32.png"
                }
                property bool isZero: tabListView.currentIndex === 0
                onIsZeroChanged: {
                    updateRadius()
                }
                updateRadius:function() {
                    if(tabListView.currentIndex === 0)
                    {
                        radius = roundRadius
                        rightBottomRound = true
                    } else {
                        rightBottomRound = false
                        radius = 0
                    }
                }
            }
            ListView {
                id: tabListView
                x: leftBtn.width
                width: parent.width - leftBtn.width
                height: tabHeight
                orientation: Qt.Horizontal
                model: 10
                interactive: false
                delegate: Item {
                    width: 140
                    height: tabHeight
                    CusRoundTabButton {
                        id: tabBtn
                        color: {
                            if (tabBtn.isSelected || tabBtn.pressed) {
                                return "#f7f7f7"
                            } else if (tabBtn.hovered) {
                                return "#7bacbf"
                            } else {
                                return "#69a2b7"
                            }
                        }
                        anchors.fill: parent
                        isFirst: index === 0
                        isLast: index === tabListView.count - 1
                        tabIndex: index
                        currentTabIndex: tabListView.currentIndex
                        onClick: {
                            tabListView.currentIndex = tabIndex
                        }
                        CusImage {
                            anchors {
                                left: parent.left
                                leftMargin: 10
                                verticalCenter: parent.verticalCenter
                            }
                            source: imgPath + "logo/milk_32.png"
                        }
                        Label {
                            color: "#3e3e3e"
                            text: "Tab " + index
                            anchors.centerIn: parent
                        }
                    }
                }
            }

            Rectangle {
                width: parent.width
                height: 1
                anchors.bottom: parent.bottom
                color: "gray"
            }
        }
    }
}
