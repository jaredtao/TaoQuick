import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0
import "../Biz"

Rectangle {
    color: CusConfig.themeColor
    Row {
        anchors.left: parent.left
        height: parent.height
        spacing: 4
        Image {
            source: imgPath + "logo/milk.png"
        }
        Text {
            id: t
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 28
            font.bold: true
            text: "TaoQuick"
            color: "#ffffff"
        }
    }
    property bool isMaxed: rootView.visibility == Window.Maximized
    Row {
        id: controlButtons
        objectName: "controlButtonsRow"
        height: 24
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 20
        spacing: 20
        CusButton_Image {
            width: 24
            height: 24
            btnImgUrl: imgPath + (hovered || pressed ? "Window/minimal_white.png" : "Window/minimal_gray.png")
            tipText: qsTr("minimal") + trans.transString
            onClicked: {
                rootView.showMinimized()
            }
        }
        CusButton_Image {
            width: 24
            height: 24
            visible: !isMaxed
            btnImgUrl: imgPath + (hovered || pressed ? "Window/max_white.png" : "Window/max_gray.png")
            tipText: qsTr("maximize") + trans.transString
            onClicked: {
                rootView.showMaximized()
            }
        }
        CusButton_Image {
            width: 24
            height: 24
            visible: isMaxed
            btnImgUrl: imgPath
                       + (hovered || pressed ? "Window/normal_white.png" : "Window/normal_gray.png")
            tipText: qsTr("normal") + trans.transString
            onClicked: {
                view.showNormal()
            }
        }
        CloseBtn {
            width: 24
            height: 24
            onClicked: {
                rootView.close()
            }
        }
    }
    Rectangle {
        id: splitLine
        height: parent.height * 0.4
        width: 1
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: controlButtons.left
        anchors.rightMargin: 10
        color: CusConfig.splitLineColor
    }
    Row {
        id: toolRow

        height: 24
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: splitLine.left
        anchors.rightMargin: 20
        spacing: 20
        SkinBtn {
            width: 24
            height: 24
            anchors.verticalCenter: parent.verticalCenter
            objectName: "skinBtn"
        }
        LangBtn {
            width: 24
            height: 24
            anchors.verticalCenter: parent.verticalCenter
            objectName: "langBtn"
        }
        CusButton_Image {
            width: 24
            height: 24
            anchors.verticalCenter: parent.verticalCenter
            tipText: qsTr("Settings") + trans.transString
            btnImgUrl: imgPath
                       + (hovered || pressed ? "Window/settings_white.png" : "Window/settings_gray.png")
            onClicked: {
                settingDialog.show()
            }
        }
        CusButton_Image {
            width: 24
            height: 24
            anchors.verticalCenter: parent.verticalCenter
            tipText: qsTr("About") + trans.transString
            btnImgUrl: imgPath
                       + (hovered || pressed ? "Window/about_white.png" : "Window/about_gray.png")
            onClicked: {
                aboutDialog.show()
            }
        }
    }
    property alias blankItem: blankItem
    Item {
        id: blankItem
        objectName: "blankItem"
        anchors {
            left: parent.left
            leftMargin: 4
            right: toolRow.left
            top: parent.top
            topMargin: 4
            bottom: parent.bottom
        }
        MouseArea {
            anchors.fill: parent
            onDoubleClicked: {
                if (rootView.visibility == Window.Windowed) {
                    rootView.showMaximized()
                } else {
                    rootView.showNormal()
                }
            }
            property point windowOffsetPos
            property point curGlobalPos
            onPressed: {
                // 鼠标按下时记录窗口上鼠标点击的位置, 后面无论鼠标移动到哪里，窗口的坐标就是鼠标实际位置减去这个点击位置。保证不会跑丢。
                // 直接通过c++获取全局鼠标坐标，映射为窗口坐标。如果用MouseArea提供的坐标或者event的坐标，会莫名其妙的抖动。
                windowOffsetPos =  rootView.globalPosToWindowPos(rootView.mousePosition())
            }
            onPositionChanged: function(mouse){
                if (rootView.visibility == Window.Maximized) {
                    rootView.showNormal()
                }
                // 当前鼠标的全局坐标。
                curGlobalPos = rootView.mousePosition()
                // 鼠标到哪，窗口就跟到那。偏移量是点击时记录的窗口内坐标。
                rootView.move(curGlobalPos.x - windowOffsetPos.x, curGlobalPos.y - windowOffsetPos.y)
            }
        }
    }
}
