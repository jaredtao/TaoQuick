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
        property string title: gridView.currentIndex === -1 ?
                                   "Component List" :
                                   componentsMgr.comps[gridView.currentIndex]["name"]
        text: trans.trans(title) + trans.transString
    }
    GridView {
        id: gridView
        anchors.centerIn: background
        width: cellWidth *  4
        height: cellHeight * 4
        cellWidth: 220
        cellHeight: 100
        model: componentsMgr.comps
        currentIndex: -1
        opacity: 1
        visible: opacity > 0

        delegate: Item {
            width: 220
            height: 100
            CompCard {
                anchors.centerIn: parent
                name: trans.trans(modelData.name) + trans.transString
                count: modelData.count
                icon: modelData.icon
                onClicked: {
                    showDetail(index)
                }
            }
        }
    }
    CompDetail {
        id: compDetail
        readonly property int initOpacity: 0
        readonly property real initScale: 0.5
        width: 400
        height: 600
        anchors.centerIn: parent

        scale: initScale
        opacity:  initOpacity
        visible: opacity > 0
        comps: gridView.currentIndex=== -1 ? [] : componentsMgr.comps[gridView.currentIndex]["comps"]
        compNames: gridView.currentIndex=== -1 ? [] : componentsMgr.comps[gridView.currentIndex]["compNames"]
        count: gridView.currentIndex=== -1 ? "" : componentsMgr.comps[gridView.currentIndex]["count"]
        icon: gridView.currentIndex=== -1 ? "" : componentsMgr.comps[gridView.currentIndex]["icon"]
        onClosed: {
            hideDetail()
        }
    }
    SequentialAnimation {
        id: showDetailAni
        NumberAnimation {
            target: gridView
            property : "opacity"
            to: 0
            duration: 240
        }
        ParallelAnimation {
            NumberAnimation {
                target: compDetail
                property: "opacity"
                to: 1.0
                duration: 260
            }
            NumberAnimation {
                target: compDetail
                property: "scale"
                to: 1.0
                duration: 260
            }
        }
    }
    SequentialAnimation {
        id: hideDetailAni
        ParallelAnimation {
            NumberAnimation {
                target: compDetail
                property: "opacity"
                to: compDetail.initOpacity
                duration: 260
            }
            NumberAnimation {
                target: compDetail
                property: "scale"
                to: compDetail.initScale
                duration: 260
            }
        }
        NumberAnimation {
            target: gridView
            property : "opacity"
            to: 1
            duration: 240
        }

    }
    function showDetail(index) {
        gridView.currentIndex = index
        showDetailAni.start()
    }
    function hideDetail() {
        gridView.currentIndex = -1
        hideDetailAni.start()
    }
}
