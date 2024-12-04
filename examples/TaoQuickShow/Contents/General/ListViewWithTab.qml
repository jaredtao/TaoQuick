import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

import QtQml.Models
import TaoQuick 1.0
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
				CusLabel {
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

				CusLabel {
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

//                        delegate: Item {
//                            width: 400
//                            height: 160
//                            CusLabel {
//                                x: 60
//                                text: modelData + ":"
//                            }
//                            Column {
//                                x: 230
//                                height: parent.height
//                                CusCheckBox {
//                                    text: "开机时自动启动"
//                                }
//                                CusCheckBox {
//                                    text: "启动时自动登录"
//                                }
//                                CusCheckBox {
//                                    text: "总是打开登录提示"
//                                }
//                            }
//                        }
//                        model: leftListView.model
						model: ObjectModel {
							Item {
								width: 400
								height: 120
								CusLabel {
									x: 60
									text: "登录" + ":"
								}
								Column {
									x: 230
									height: parent.height
									spacing: 6
									CusCheckBox {
										text: "开机时自动启动"
									}
									CusCheckBox {
										text: "启动时自动登录"
									}
									CusCheckBox {
										text: "总是打开登录提示"
									}
								}
							}
							Item {
								width: 400
								height: 340
								CusLabel {
									x: 60
									text: "状态" + ":"
								}
								Column {
									x: 230
									height: parent.height
									Row {
									 CusLabel {
										text: "登录后状态为:"
									 }
									 CusComboBox {
										model: ["在线","忙碌","隐身"]
										width: 100
									 }
									}
									CusCheckBox {
										text: "运行全屏程序时切换至“忙碌”状态"
									}
									CusLabel {
										x: 30
										text: "仅在“我在线上”状态下生效"
										enabled: false
									}
									Row {
										CusCheckBox {
											text: "鼠标键盘无动作"
										}
										CusSpinBox {
											value: 5
											from: 1
											to: 999
										}
										CusLabel {
											text: "分钟后："
										}
									}

									Row {
										x: 30
										CusRadioButton {
											id: radio_stateTo
											text: "将状态切换至"

										}
										CusComboBox {
											model:["忙碌"]
										}
									}
									CusRadioButton {
										id: radio_lock
										text: "自动锁定"
									}
									ButtonGroup {
										id: onlineStateChangeGroup
										buttons: [radio_stateTo, radio_lock]
									}
									CusCheckBox {
										text: "离开、忙碌、请勿打扰时自动回复(100字以内)"
									}
									Row {
										CusButton {
											text: "自动回复设置"
										}
										CusButton {
											text: "快捷回复设置"
										}
									}
								}
							}
							Item {
								width: 400
								height: 160
								CusLabel {
									x: 60
									text: "会话窗口" + ":"
								}
								Column {
									x: 230
									height: parent.height
									CusCheckBox {
										text: "开机时自动启动"
									}
									CusCheckBox {
										text: "启动时自动登录"
									}
									CusCheckBox {
										text: "总是打开登录提示"
									}
								}
							}
							Item {
								width: 400
								height: 160
								CusLabel {
									x: 60
									text: "提醒" + ":"
								}
								Column {
									x: 230
									height: parent.height
									CusCheckBox {
										text: "开机时自动启动"
									}
									CusCheckBox {
										text: "启动时自动登录"
									}
									CusCheckBox {
										text: "总是打开登录提示"
									}
								}
							}
							Item {
								width: 400
								height: 120
								CusLabel {
									x: 60
									text: "热键" + ":"
								}
								Column {
									x: 230
									height: parent.height
									spacing: 6
									CusCheckBox {
										text: "开机时自动启动"
									}
									CusCheckBox {
										text: "启动时自动登录"
									}
									CusCheckBox {
										text: "总是打开登录提示"
									}
								}
							}
							Item {
								width: 400
								height: 120
								CusLabel {
									x: 60
									text:  "声音" + ":"
								}
								Column {
									x: 230
									height: parent.height
									spacing: 6
									CusCheckBox {
										text: "开机时自动启动"
									}
									CusCheckBox {
										text: "启动时自动登录"
									}
									CusCheckBox {
										text: "总是打开登录提示"
									}
								}
							}
							Item {
								width: 400
								height: 120
								CusLabel {
									x: 60
									text: "软件更新" + ":"
								}
								Column {
									x: 230
									height: parent.height
									spacing: 6
									CusCheckBox {
										text: "开机时自动启动"
									}
									CusCheckBox {
										text: "启动时自动登录"
									}
									CusCheckBox {
										text: "总是打开登录提示"
									}
								}
							}
							Item {
								width: 400
								height: 120
								CusLabel {
									x: 60
									text: "文件管理" + ":"
								}
								Column {
									x: 230
									height: parent.height
									spacing: 6
									CusCheckBox {
										text: "开机时自动启动"
									}
									CusCheckBox {
										text: "启动时自动登录"
									}
									CusCheckBox {
										text: "总是打开登录提示"
									}
								}
							}
							Item {
								width: 400
								height: 120
								CusLabel {
									x: 60
									text: "文件共享" + ":"
								}
								Column {
									x: 230
									height: parent.height
									spacing: 6
									CusCheckBox {
										text: "开机时自动启动"
									}
									CusCheckBox {
										text: "启动时自动登录"
									}
									CusCheckBox {
										text: "总是打开登录提示"
									}
								}
							}
							Item {
								width: 400
								height: 120
								CusLabel {
									x: 60
									text: "音视频通话" + ":"
								}
								Column {
									x: 230
									height: parent.height
									spacing: 6
									CusCheckBox {
										text: "开机时自动启动"
									}
									CusCheckBox {
										text: "启动时自动登录"
									}
									CusCheckBox {
										text: "总是打开登录提示"
									}
								}
							}
						}
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
