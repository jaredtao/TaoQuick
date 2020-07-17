import QtQuick 2.12
import QtQuick.Controls 2.12
import TaoQuick 1.0
import "qrc:/TaoQuick"
Item {
    anchors.fill: parent

    property var images:[
        imgPath + "Effect/Girls/girl1.jpeg",
        imgPath + "Effect/Girls/girl2.jpeg",
        imgPath + "Effect/Girls/girl3.jpeg",
        imgPath + "Effect/Girls/girl4.jpeg",
        imgPath + "Effect/Girls/girl5.jpeg",
        imgPath + "Effect/Girls/girl6.jpeg",
        imgPath + "Effect/Girls/girl7.jpeg",
        imgPath + "Effect/Girls/girl8.jpeg",
        imgPath + "Effect/Girls/girl9.jpeg",
        imgPath + "Effect/Girls/girl10.jpeg",
        imgPath + "Effect/Girls/girl11.jpeg",
        imgPath + "Effect/Girls/girl12.jpeg",
        imgPath + "Effect/Girls/girl14.jpeg",
        imgPath + "Effect/Girls/girl15.jpeg"
    ]
    PageSwitchBase {
        id: c
        width: 500
        height: 750
        anchors.centerIn: parent
        maxCount: images.length
        property int dir: 0
        Repeater {
            model: images
            SBoard {
                anchors.fill: parent
                sourceItem: Image { source: images[index] }
                dir: c.dir
                state: index === c.currentIndex ? "show" : "hide"
            }
        }
    }
    Column {
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        Switch {
            id: autoPlaySwitch
            text: "Auto Play"
            checked: true
        }
        ComboBox {
            model: ["ToRight","ToBottom"]
            onCurrentIndexChanged: {
                c.dir = currentIndex
            }
        }
    }
    Timer {
        id: autoPlayTimer
        interval: 2800
        running: autoPlaySwitch.checked
        repeat: true
        property bool reserve: false
        triggeredOnStart: true
        onTriggered: {
            if (reserve) {
                c.currentIndex--;
            } else {
                c.currentIndex++;
            }
            if (c.currentIndex >= images.length - 1) {
                reserve = true;
            } else if(c.currentIndex <= 0) {
                reserve = false;
            }
        }
    }
}
