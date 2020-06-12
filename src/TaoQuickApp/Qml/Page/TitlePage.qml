import QtQuick 2.12
import QtQuick.Controls 2.12
import TaoQuick 1.0
import "qrc:/TaoQuick"

Rectangle {
    Row {
        anchors.left: parent.left
        height: parent.height
        spacing: 4
        Image {
            source: "qrc:/Image/logo/milk.png"
        }
        Text {
            id: t
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 28
            font.bold: true
            text: "TaoQuick"
        }
    }

    property bool isMaxed: false
    Row {
        id: controlButtons
        height: 20
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 12
        spacing: 10
        TImageBtn {
            width: 20
            height: 20
            imageUrl: containsMouse ? "qrc:/Image/Window/minimal_white.png" : "qrc:/Image/Window/minimal_gray.png"
            onClicked: {
                view.showMinimized()
            }
        }
        TImageBtn {
            width: 20
            height: 20
            visible: !isMaxed
            imageUrl: containsMouse ? "qrc:/Image/Window/max_white.png" : "qrc:/Image/Window/max_gray.png"
            onClicked: {
                view.showMaximized()
                isMaxed = true
            }
        }
        TImageBtn {
            width: 20
            height: 20
            visible: isMaxed
            imageUrl: containsMouse ? "qrc:/Image/Window/normal_white.png" : "qrc:/Image/Window/normal_gray.png"
            onClicked: {
                view.showNormal()
                isMaxed = false
            }
        }
        TImageBtn {
            width: 20
            height: 20
            imageUrl: containsMouse ? "qrc:/Image/Window/close_white.png" : "qrc:/Image/Window/close_gray.png"
            onClicked: {
                view.close()
            }
        }
    }
    Rectangle {
        id: splitLine
        height: 16
        width: 1
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: controlButtons.left
        anchors.rightMargin: 10
    }
    Row {
        height: 20
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: splitLine.left
        anchors.rightMargin: 10
        spacing: 10
        TImageBtn {
            width: 20
            height: 20
            anchors.verticalCenter: parent.verticalCenter
            imageUrl: containsMouse ? "qrc:/Image/Window/skin_white.png" : "qrc:/Image/Window/skin_gray.png"
            onClicked: {
                skinBox.show()
            }
            TPopup {
                id: skinBox
                barColor: gConfig.reserverColor
                backgroundWidth: 280
                backgroundHeight: 180
                contentItem: GridView {
                    anchors.fill: parent
                    anchors.margins: 10
                    model: gConfig.themes
                    cellWidth: 80
                    cellHeight: 80
                    clip: true
                    delegate: Item {
                        width: 80
                        height: 80
                        Rectangle {
                            anchors.fill: parent
                            anchors.margins: 4
                            height: width
                            color: model.titleBackground
                        }
                        Rectangle {
                            anchors.fill: parent
                            color: "transparent"
                            border.color: model.titleBackground
                            border.width: 2
                            visible: a.containsMouse
                        }
                        Text {
                            anchors {
                                left: parent.left
                                bottom: parent.bottom
                                leftMargin: 8
                                bottomMargin: 8
                            }
                            color: "white"
                            text: model.name
                        }
                        Rectangle {
                            x: parent.width - width
                            y: parent.height - height
                            width: 20
                            height: width
                            radius: width / 2
                            color: model.titleBackground
                            border.width: 3
                            border.color: gConfig.reserverColor
                            visible: gConfig.currentTheme === index
                        }
                        MouseArea {
                            id: a
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                gConfig.currentTheme = index
                            }
                        }
                    }
                }

            }
        }
        TImageBtn {
            width: 20
            height: 20
            anchors.verticalCenter: parent.verticalCenter
            imageUrl: containsMouse ? "qrc:/Image/Window/lang_white.png" : "qrc:/Image/Window/lang_gray.png"
            onClicked: {
                //                notifyBox.notify("change language")
                pop.show()
            }
            TPopup {
                id: pop
                barColor: gConfig.reserverColor
                backgroundWidth: 100
                backgroundHeight: 400
                contentItem: ListView {
                    id: langListView
                    anchors.fill: parent
                    anchors.margins: 2
                    model: view.languageList
                    clip: true
                    delegate: TTextBtn {
                        width: langListView.width
                        height: 36
                        text: modelData
                        color: view.currentLang === modelData ? gConfig.titleBackground :( containsMouse ? "lightgray" : pop.barColor)
                        textColor: gConfig.textColor
                        onClicked: {
                            pop.hide()
                            view.reTrans(modelData)
                        }
                    }
                }
            }
        }
        TImageBtn {
            width: 20
            height: 20
            anchors.verticalCenter: parent.verticalCenter

            imageUrl: containsMouse ? "qrc:/Image/Window/about_white.png" : "qrc:/Image/Window/about_gray.png"
            onClicked: {
                aboutDialog.show()
            }
        }
    }
}
