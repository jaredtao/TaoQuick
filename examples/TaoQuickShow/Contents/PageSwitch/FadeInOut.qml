import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0
import "qrc:/TaoQuick"
Item {
    id: r

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
        Repeater {
            model: images
            SFadeInOut {
                anchors.fill: parent
                sourceItem: Image { source: images[index] }
                state: index === c.currentIndex ? "show" : "hide"
            }
        }
    }
    Switch {
        id: autoPlaySwitch
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        text: "Auto Play"
        checked: true
    }
    Timer {
        id: autoPlayTimer
        interval: 2400
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
