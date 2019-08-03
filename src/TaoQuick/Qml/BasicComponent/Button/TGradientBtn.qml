/****************************************************************************
 **
 ** This file is part of the TaoQuick project.
 **
 ** Copyright 2019 JaredTao jared2020@163.com. https://github.com/jaredtao

****************************************************************************/

import QtQuick 2.12
import QtQuick.Controls 2.12


/*!
    \qmltype TGradientBtn
    \inqmlmodule TaoQuick
    \inherits Item
    \since 1.0
    \ingroup Button
    \brief 提供一个Material风格的按钮，点击的地方有圆弧放大的动画。

    渐变按钮，参考Material风格实现，鼠标点击的地方一个圆弧，逐渐放大。
    示例代码:
    \qml
    TGradientBtn {
        text: qsTr("Button")
        width: 120
        height: 40
        onClicked: {
            console.log("渐变按钮被按下")
        }
    }
    \endqml
*/
Item {
    id: root

    /*!
        \qmlproperty string TGradientBtn::text

        渐变按钮要显示的文字
     */
    property alias text: t.text

    /*!
        \qmlproperty color TGradientBtn::textColor

        渐变按钮文字的颜色
     */
    property alias textColor: t.color

    /*!
        渐变按钮文字的锚布局。默认为居中
     */
    property alias textAnchors: t.anchors

    /*!
        \qmlproperty enum TGradientBtn::textHorizontalAlignment

        渐变按钮文字的垂直对齐方式。默认为垂直居中
     */
    property alias textHorizontalAlignment: t.horizontalAlignment

    /*!
        \qmlproperty enum TGradientBtn::textVerticalAlignment

        渐变按钮文字的水平对齐方式。默认为水平居中
     */
    property alias textVerticalAlignment: t.verticalAlignment

    /*!
        渐变按钮文字Text实例，可以直接修改这个实例的属性

        \qml
        TGradientBtn {

            textItem.text: qsTr("Button")
            textItem.color: "red"

            width: 120
            height: 40
            onClicked: {
                console.log("渐变按钮被按下")
            }
        }
        \endqml
     */
    property alias textItem: t

    /*!
        \qmlproperty bool TGradientBtn::containsMouse

        渐变按钮是否有鼠标悬浮
     */
    property alias containsMouse: mouseBtn.containsMouse
    /*!
        \qmlproperty bool TGradientBtn::containsMouse

        渐变按钮是否有鼠标按下
     */
    property alias containsPress: mouseBtn.containsPress

    /*!
        \qmlsignal TGradientBtn::clicked()

        渐变按钮按下时，发出此信号
     */
    signal clicked();

    Rectangle {
        id: hoverRect
        anchors.fill: parent
        visible: root.containsMouse || root.containsPress
        color: Qt.lighter("gray")
        radius: 5
        clip: true
        Rectangle {
            id: pressRect
            radius: 0
            smooth: true
            property int startX: root.width / 2
            property int startY: root.height / 2
            x: startX - radius
            y: startY - radius
            width: radius * 2
            height: radius * 2
            visible: radius > 0
            color: "gray"

            SequentialAnimation {
                id: pressAnimation
                NumberAnimation {
                    target: pressRect
                    property: "radius"
                    from: 0
                    to: Math.max(pressRect.startX, root.width - pressRect.startX)
                    duration: 500
                }
                ScriptAction {
                    script: {
                        pressRect.radius = 0
                    }
                }
            }
        }
    }

    Text {
        id: t
        anchors.centerIn: parent
        width: parent.width
    }
    MouseArea {
        id: mouseBtn
        anchors.fill: parent;
        hoverEnabled: parent.enabled;
        onPressed: {
            pressRect.startX = mouseX
            pressRect.startY = mouseY
            pressAnimation.start()
        }
        onClicked: root.clicked();
        cursorShape: Qt.PointingHandCursor
    }
}
