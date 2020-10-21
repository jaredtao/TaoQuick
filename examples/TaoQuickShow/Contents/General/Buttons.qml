import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0

Item {
    anchors.fill: parent
    readonly property color blueNormal: "#1890ff"
    readonly property color blueHover: "#40a9ff"
    readonly property color bluePressed: "#096dd9"
    Column {
        anchors.centerIn: parent
        spacing: 10
        CusLabel {
            text: qsTr("General Button is consist of text, background and tooltip, it has normal, hover, pressed and disable states") + trans.transString
            wrapMode: Label.WordWrap
            width: 400
        }
        Row {
            spacing: 20
            CusButton {
                width: 120
                height: 30
                text: "Hello Button"
            }

            CusButton {
                width: 120
                height: 30
                text: "Button with tip"
                tipText: "Hello, i am tip"
            }
            CusButton {
                width: 120
                height: 30
                enabled: false
                text: "Disable Button"
            }
        }
        Item {
            width: 20
            height: 30
        }
        CusLabel {
            text: qsTr("Text Button has no background and border") + trans.transString
            wrapMode: Label.WordWrap
            width: 400
        }
        Row {
            spacing: 20
            CusTextButton {
                width: 120
                height: 30
                text: "Text Button"
                backgroundColor: "transparent"
                borderColor: "transparent"
            }
            CusTextButton {
                width: 120
                height: 30
                text: "Text Button with tip"
                tipText: "Hello, i am textButton tip"
                backgroundColor: "transparent"
                borderColor: "transparent"
            }
            CusTextButton {
                width: 120
                height: 30
                text: "Text Button"
                enabled: false
                backgroundColor: "transparent"
                borderColor: "transparent"
            }
        }
        Item {
            width: 20
            height: 30
        }
        CusLabel {
            text: qsTr("Material Button has a gradiant background when clicked") + trans.transString
            wrapMode: Label.WordWrap
            width: 400
        }
        Row {
            spacing: 20
            CusButton_Gradient {
                width: 120
                height: 30
                text: "Material Button"
            }
        }
        Item {
            width: 20
            height: 30
        }
        CusLabel {
            text: qsTr("Button can be design with different colors according to importance, example: blue for normal operation, red for delete operation and white for cancel operation") + trans.transString
            wrapMode: Label.WordWrap
            width: 400
        }
        Row {
            spacing: 20

            CusButton_Blue {
                width: 120
                height: 30
                text: "Blue Button"
            }

            CusButton_Blue {
                width: 120
                height: 30
                text: "Button with tip"
                tipText: "i am blue button"
            }
            CusButton_Blue {
                width: 120
                height: 30
                text: "Blue Button"
                enabled: false
            }
        }
        Row {
            spacing: 20

            CusButton_White {
                width: 120
                height: 30
                text: "White Button"
            }

            CusButton_White {
                width: 120
                height: 30
                text: "Button with tip"
                tipText: "i am white button"
            }
            CusButton_White {
                width: 120
                height: 30
                text: "White Button"
                enabled: false
            }
        }
        Row {
            spacing: 20

            CusButton_Red {
                width: 120
                height: 30
                text: "Red Button"
            }

            CusButton_Red {
                width: 120
                height: 30
                text: "Button with tip"
                tipText: "i am red button"
            }
            CusButton_Red {
                width: 120
                height: 30
                text: "Red Button"
                enabled: false
            }
        }
        Item {
            width: 20
            height: 30
        }
        CusLabel {
            text: qsTr("General Button can be custom style, such as round background, icon background, icon text ans so on") + trans.transString
            wrapMode: Label.WordWrap
            width: 400
        }
        Row {
            spacing: 20
            CusButton_Image {
                btnImgNormal: imgPath + "Button/download_black.png"
                btnImgHovered: imgPath + "Button/download_blue.png"
                btnImgPressed: imgPath + "Button/download_red.png"
                btnImgDisbaled: imgPath + "Button/download_gray.png"
                tipText: "Download Button"
                width: 36
                height: 36
            }
            CusButton_ImageColorOverlay {
                btnImgNormal: imgPath + "Button/download_black.png"
                tipText: "Download Button Color Overlay"
                width: 36
                height: 36
            }

            CusButton_Image {
                id: backBtn1
                width: 36
                height: 36
                background: Rectangle {
                    width: 36
                    height: 36
                    color: backBtn1.pressed ? bluePressed : (backBtn1.hovered ? blueHover : blueNormal)
                    radius: 2
                    CusImage {
                        source: imgPath + "Button/download_white.png"
                        anchors.centerIn: parent
                    }
                }
            }
            CusButton_Image {
                id: backBtn2
                width: 36
                height: 36
                background: Rectangle {
                    width: 36
                    height: width
                    radius: width / 2
                    color: backBtn2.pressed ? bluePressed : (backBtn2.hovered ? blueHover : blueNormal)
                    CusImage {
                        source: imgPath + "Button/download_white.png"
                        anchors.centerIn: parent
                    }
                }
            }
            CusButton_Image {
                id: backBtn3
                width: 70
                height: 36
                background: Rectangle {
                    width: 70
                    height: 36
                    color: backBtn3.pressed ? bluePressed : (backBtn3.hovered ? blueHover : blueNormal)
                    radius: height / 2
                    CusImage {
                        source: imgPath + "Button/download_white.png"
                        anchors.centerIn: parent
                    }
                }
            }
            CusButton_Image {
                id: backBtn3_1
                width: 36
                height: 36
                property bool isDownload: false
                background: Rectangle {
                    width: 36
                    height: 36
                    color: backBtn3_1.pressed ? bluePressed : (backBtn3_1.hovered ? blueHover : blueNormal)
                    radius: 2
                    CusImage {
                        source: imgPath + "Button/expand.png"
                        anchors.centerIn: parent
                        rotation: backBtn3_1.isDownload ? 180 : 0
                        Behavior on rotation { NumberAnimation { duration: 300}}
                    }
                }
                onClicked: {
                    isDownload = !isDownload
                }
            }
            CusButton_Image {
                id: backBtn4
                width: 120
                height: 36
                background: Rectangle {
                    width: 120
                    height: 36
                    color: backBtn4.pressed ? bluePressed : (backBtn4.hovered ? blueHover : blueNormal)
                    radius: height / 2
                    Row {
                        anchors.centerIn: parent
                        CusImage {
                            source: imgPath + "Button/download_white.png"
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        CusLabel {
                            text: "Download"
                            anchors.verticalCenter: parent.verticalCenter
                            color: "#ffffff"
                        }
                    }
                }
            }
            CusButton_Image {
                id: backBtn5
                width: 120
                height: 36
                background: Rectangle {
                    width: 120
                    height: 36
                    color: backBtn5.pressed ? bluePressed : (backBtn5.hovered ? blueHover : blueNormal)
                    radius: 2
                    Row {
                        anchors.centerIn: parent
                        CusImage {
                            source: imgPath + "Button/download_white.png"
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        CusLabel {
                            text: "Download"
                            anchors.verticalCenter: parent.verticalCenter
                            color: "#ffffff"
                        }
                    }
                }
            }
        }
    }
}
