import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0

PageSwitchBase {
    id: c
    anchors.fill: parent

    images:[
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
    Image {
        id: dissolveSrc1
        source: imgPath + "Effect/Dissolve_1.jpg"
        visible: false
    }
    Image {
        id: dissolveSrc2
        source: imgPath + "Effect/Dissolve_2.png"
        visible: false
    }
    Item {
        width: 400
        height: 600
        anchors.centerIn: parent
        Repeater {
            model: images
            SDissolve {
                anchors.fill: parent
                sourceItem: Image { source: images[index] }
                dissolveImage: dissolveSrc1
                state: index === c.currentIndex ? "show" : "hide"
            }
        }
    }
}
