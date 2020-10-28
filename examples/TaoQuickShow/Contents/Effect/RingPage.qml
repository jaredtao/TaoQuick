import QtQuick 2.9
import QtQuick.Controls 2.2
import "./Effects"
TRingPage {
    id: ringPage
    anchors.fill: parent

    property var names: ["一", "二 ", "三", "四", "五", "六", "七", "八", "九", " 十", "百", "千", "万", "亿", "兆", "京", "垓 ", "杼", "穰", "沟", "涧", "正", "载", "极"]
    radiusOffset: 40
    inRadius: width / 3 - radiusOffset * 4
    property bool add: false
    onIndexAdded: {
        add = true;
        ani.restart()
    }
    onIndexDeced: {
        add = false
        ani.restart()
    }
    Text {
        id: t
        text: names[currentIndex]
        anchors.centerIn: parent

        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: Qt.darker(ringPage.colors[currentIndex], 1.5)
        font.pixelSize: 60
//        renderType: Text.NativeRendering
        scale: 1
        Behavior on opacity { NumberAnimation { duration: 300} }
        Behavior on scale { NumberAnimation{ duration: 300} }
    }
    SequentialAnimation {
        id: ani
        alwaysRunToEnd: true
        ParallelAnimation {
            ScriptAction {
                script: {
                    t.opacity = 0
                }
            }
            ScriptAction {
                script: {
                    t.scale = ringPage.add ? 0.1 : 4
                }
            }
        }

        PauseAnimation {
            duration: 200
        }
        ParallelAnimation {
            ScriptAction {
                script: {
                    t.text = ringPage.names[ringPage.currentIndex]
                }
            }
            ScriptAction {
                script: {
                    t.opacity = 1
                }
            }
            ScriptAction {
                script: {
                    t.scale = 1
                }
            }
        }
    }
}
