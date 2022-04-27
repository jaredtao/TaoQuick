import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQml.Models 2.0

Item {
    anchors.fill: parent
    Rectangle {
        border.width: 1
        border.color: "gray"
        anchors{
            centerIn: parent
        }
        width: 800
        height: 640
        clip: true
        Column {
            anchors.fill: parent
            anchors.margins: 2
            spacing: 0
            Item {
                id: titleItem
                width: parent.width
                height: 60
                Label {
                    font.pixelSize: 18
                    text: qsTr("系统设置")
                    anchors {
                        left: parent.left
                        leftMargin: 10
                        verticalCenter: parent.verticalCenter
                    }
                }
            }
            Rectangle {
                width: parent.width
                height: 1
                color: "#ededed"
            }
            Item {
                id: tabItem
                width: parent.width
                height: 60

                Label {
                    text: qsTr("基本设置")
                    anchors {
                        left: parent.left
                        leftMargin: 10
                        verticalCenter: parent.verticalCenter
                    }
                }
            }
            Rectangle {
                width: parent.width
                height: 1
                color: "#ededed"
            }
            Item {
                id: listItem
                width: parent.width
                height: 638
                Item {
                    id: leftItem
                    width: 160
                    height: parent.height
                    ListView {
                        id: leftListView
                        anchors.fill: parent
                        model: ["登录", "状态", "会话窗口", "提醒", "热键", "声音", "软件更新", "文件管理", "文件共享", "音视频通话"]
                        delegate: Button {
                            id: btn
                            width: 160
                            height: 40
                            property bool isSelected: leftListView.currentIndex === index
                            text: modelData
                            background: Rectangle {
                                width: btn.width
                                height: btn.height
                                color: {
                                    if (btn.isSelected || btn.pressed) {
                                        return "#ffffff"
                                    } else if (btn.hovered) {
                                        return "#e1e6eb"
                                    } else {
                                        return "#f0f0f1"
                                    }
                                }
                            }
                            onClicked: {
                                leftListView.currentIndex = index

                                //互斥锁 锁上,别让右边再把信号搞回来
                                rightListView.notifyLeft = false

                                rightListView.positionViewAtIndex(
                                            index, ListView.Beginning)
                                //解锁
                                rightListView.notifyLeft = true
                            }
                        }
                    }
                }
                Item {
                    id: rightItem
                    width: parent.width - leftItem.width
                    x: leftItem.width
                    height: parent.height
                    ListView {
                        id: rightListView
                        anchors.fill: parent
                        clip: true

                        //互斥flag
                        property bool notifyLeft: true

                        delegate: Item {
                            width: 400
                            height: 160
                            Label {
                                x: 60
                                text: modelData + ":"
                            }
                            Column {
                                x: 230
                                height: parent.height
                                CheckBox {
                                    text: "开机时自动启动"
                                }
                                CheckBox {
                                    text: "启动时自动登录"
                                }
                                CheckBox {
                                    text: "总是打开登录提示"
                                }
                            }
                        }
                        model: leftListView.model
                        onContentYChanged: {
                            if (notifyLeft) {
                                var i = rightListView.indexAt(0, contentY)
                                leftListView.currentIndex = i
                            }
                        }
                    }
                }
            }
        }
    }
}
