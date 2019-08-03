import QtQuick 2.12
import QtQuick.Controls 2.12
import TaoQuick 1.0
import "qrc:/Tao/Qml"
Item {
    id: r

    anchors.fill: parent

    property var images:[
        "qrc:/EffectImage/Img/Girls/girl1.jpeg",
        "qrc:/EffectImage/Img/Girls/girl2.jpeg",
        "qrc:/EffectImage/Img/Girls/girl3.jpeg",
        "qrc:/EffectImage/Img/Girls/girl4.jpeg",
        "qrc:/EffectImage/Img/Girls/girl5.jpeg",
        "qrc:/EffectImage/Img/Girls/girl6.jpeg",
        "qrc:/EffectImage/Img/Girls/girl7.jpeg",
        "qrc:/EffectImage/Img/Girls/girl8.jpeg",
        "qrc:/EffectImage/Img/Girls/girl9.jpeg",
        "qrc:/EffectImage/Img/Girls/girl10.jpeg",
        "qrc:/EffectImage/Img/Girls/girl11.jpeg",
        "qrc:/EffectImage/Img/Girls/girl12.jpeg",
        "qrc:/EffectImage/Img/Girls/girl14.jpeg",
        "qrc:/EffectImage/Img/Girls/girl15.jpeg"
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
