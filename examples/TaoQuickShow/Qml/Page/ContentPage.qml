import QtQuick 2.12
import QtQuick.Controls 2.12
import TaoQuick 1.0
import "qrc:/TaoQuick"
import "Biz"
Background {
    id: background
    TText {
        id: titleText
        font.pixelSize: 22
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 60
        }
        text: "Component List"
    }
    GridView {
        id: gridView
        anchors.centerIn: background
        width: cellWidth *  4
        height: cellHeight * 4
        model: componentsMgr.comps
        currentIndex: -1
        cellWidth: 220
        cellHeight: 100
        visible: opacity > 0
        delegate: Item {
            width: 220
            height: 100
            CompCard {
                anchors.centerIn: parent
                name: modelData.name
                count: modelData.count
                icon: modelData.icon
                onClicked: {
                    gridView.currentIndex = index
                }
            }
        }
    }

//    CompBtn {
//        anchors.centerIn: parent
//        targetParent: background
//        name: modelData.name
//        count: modelData.count
//        icon: modelData.icon
//        compNames: modelData.compNames
//        visible: gridView.currentIndex === -1 || gridView.currentIndex === index
//        //                onClicked: {
//        //                    gridView.currentIndex = index
//        //                }
//        //                onClosed: {
//        //                    gridView.currentIndex = -1
//        //                }
//    }
}
