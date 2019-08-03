import QtQuick 2.12
import QtQuick.Controls 2.12
import TaoQuick 1.0
import "qrc:/Tao/Qml/"
Item {
    anchors.fill: parent
    property color btnColor: "#06b7ed"
    property color btnBorderColor: "orange"
    Grid {
        width: parent.width - 20
        x: 10
        y: 10
        rowSpacing: 20
        columnSpacing: 10
        columns: 6
        TTextBtn {
            width: 80
            height: 40
            text: qsTr("文本按钮")
            color: containsPress ? Qt.darker(btnColor, 1.2) : (containsMouse ? Qt.lighter(btnColor, 1.2) : btnColor)
            border.width: containsMouse ? 2 : 0
            border.color: btnBorderColor
            onClicked: {
                console.log("你按下了文本按钮")
            }
        }
        TTextBtn {
            width: 120
            height: 40
            radius: 20
            property color btnColor: "#06b7ed"

            color: containsPress ? Qt.darker(btnColor, 1.2) : (containsMouse ? Qt.lighter(btnColor, 1.2) : btnColor)
            border.width: containsMouse ? 2 : 0
            border.color: btnBorderColor
            text: qsTr("圆角文本按钮")
            onClicked: {
                console.log("你按下了圆角文本按钮")
            }
        }
        TTextBtn {
            width: 120
            height: 40
            radius: 20
            text: qsTr("圆角文本按钮")
            color: containsPress ? Qt.darker(btnColor, 1.2) : (containsMouse ? Qt.lighter(btnColor, 1.2) : btnColor)
            border.width: containsMouse ? 2 : 0
            border.color: btnBorderColor
            textColor: "red"
            onClicked: {
                console.log("你按下了圆角文本按钮")
            }
        }
        TTextBtn {
            width: 60
            height: width
            radius: width / 2
            text: qsTr("圆按钮")
            textColor: "red"

            color: containsPress ? Qt.darker(btnColor, 1.2) : (containsMouse ? Qt.lighter(btnColor, 1.2) : btnColor)
            border.width: containsMouse ? 2 : 0
            border.color: btnBorderColor
            onClicked: {
                console.log("你按下了圆角文本按钮")
            }
        }
        TTextBtn {
            id: gradientBtn
            width: 120
            height: 40
            radius: 5
            text: qsTr("渐变按钮")
            textColor: "red"
            color: btnColor
            gradient: Gradient {
                GradientStop { position: 0 ; color: Qt.darker(btnColor, 1.2) }
                GradientStop { position: 0.3 ; color:  Qt.darker(btnColor, 1.4)  }
                GradientStop { position: 0.6 ; color:  Qt.darker(btnColor, 1.6)  }
                GradientStop { position: 1 ; color:  Qt.darker(btnColor, 1.8) }
            }
            border.width: containsMouse ? 2 : 0
            border.color: btnBorderColor
//            color: btnColor
            //color: containsPress ? Qt.darker(btnColor, 1.2) : (containsMouse ? Qt.lighter(btnColor, 1.2) : btnColor)
            onClicked: {
                console.log("你按下了圆角文本按钮")
            }
        }
        TTextBtn {
            id: gradientBtn2
            width: 120
            height: 40
            radius: 5
            text: qsTr("渐变按钮")
            textColor: "red"

            gradient: 19
            color: containsPress ? Qt.darker(btnColor, 1.2) : (containsMouse ? Qt.lighter(btnColor, 1.2) : btnColor)
            border.width: containsMouse ? 2 : 0
            border.color: btnBorderColor
            onClicked: {
                console.log("你按下了圆角文本按钮")
            }
        }
        TImageBtn {
            width: 48
            height: 48
            normalUrl: "qrc:/Image/Button/smile-fill.png"
            hoveredUrl: "qrc:/Image/Button/smile-fill-hover.png"
            pressedUrl: "qrc:/Image/Button/cry-fill.png"
            onClicked: {
                console.log("你按下了图片按钮")
            }
        }

        TImgTextBtn {
            width: 100
            height: 48
            normalUrl: "qrc:/Image/Button/smile-fill.png"
            hoveredUrl: "qrc:/Image/Button/smile-fill-hover.png"
            pressedUrl: "qrc:/Image/Button/cry-fill.png"
            text: qsTr("图文按钮")
            color: containsPress ? Qt.darker(btnColor, 1.2) : (containsMouse ? Qt.lighter(btnColor, 1.2) : btnColor)
            border.width: containsMouse ? 2 : 0
            border.color: btnBorderColor
            layoutType: layoutImageLeft
            onClicked: {
                console.log("你按下了图片按钮")
            }
        }
        TImgTextBtn {
            width: 100
            height: 48
            normalUrl: "qrc:/Image/Button/smile-fill.png"
            hoveredUrl: "qrc:/Image/Button/smile-fill-hover.png"
            pressedUrl: "qrc:/Image/Button/cry-fill.png"
            text: qsTr("图文按钮")
            color: containsPress ? Qt.darker(btnColor, 1.2) : (containsMouse ? Qt.lighter(btnColor, 1.2) : btnColor)
            border.width: containsMouse ? 2 : 0
            border.color: btnBorderColor
            layoutType: layoutImageRight
            onClicked: {
                console.log("你按下了图片按钮")
            }
        }
        TImgTextBtn {
            width: 80
            height: 60
            normalUrl: "qrc:/Image/Button/smile-fill.png"
            hoveredUrl: "qrc:/Image/Button/smile-fill-hover.png"
            pressedUrl: "qrc:/Image/Button/cry-fill.png"
            text: qsTr("图文按钮")
            color: containsPress ? Qt.darker(btnColor, 1.2) : (containsMouse ? Qt.lighter(btnColor, 1.2) : btnColor)
            border.width: containsMouse ? 2 : 0
            border.color: btnBorderColor
            layoutType: layoutImageUp
            onClicked: {
                console.log("你按下了图片按钮")
            }
        }
        TImgTextBtn {
            width: 80
            height: 60
            normalUrl: "qrc:/Image/Button/smile-fill.png"
            hoveredUrl: "qrc:/Image/Button/smile-fill-hover.png"
            pressedUrl: "qrc:/Image/Button/cry-fill.png"
            text: qsTr("图文按钮")
            color: containsPress ? Qt.darker(btnColor, 1.2) : (containsMouse ? Qt.lighter(btnColor, 1.2) : btnColor)
            border.width: containsMouse ? 2 : 0
            border.color: btnBorderColor
            layoutType: layoutImageDown
            onClicked: {
                console.log("你按下了图片按钮")
            }
        }
    }
}
