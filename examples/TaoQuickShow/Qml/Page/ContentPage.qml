import QtQuick 2.12
import QtQuick.Controls 2.12
import TaoQuick 1.0
import "qrc:/TaoQuick"
import "Biz"
Background {
    id: background
    readonly property string defaultTitle: "Component List"
    TText {
        id: titleText
        font.pixelSize: 22
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 60
        }
        property string title: defaultTitle
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
                    setTitle(modelData.name)
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
        compNames: gridView.currentIndex=== -1 ? [] : componentsMgr.comps[gridView.currentIndex]["compNames"]
        comps: gridView.currentIndex=== -1 ? [] : componentsMgr.comps[gridView.currentIndex]["comps"]
        icon: gridView.currentIndex=== -1 ? "" : componentsMgr.comps[gridView.currentIndex]["icon"]
        onClosed: {
            setTitle(defaultTitle)
            hideDetail()
        }
        onCompClicked: {
            setTitle(compName)
            showComp(compUrl)
        }
    }
    Loader {
        id: compLoader
        anchors.fill: parent
        visible: opacity > 0
        opacity: 0
        onLoaded: {
            item.anchors.centerIn = compLoader
            item.anchors.margins = 100
        }
        BackBtn {
            anchors {
                left: parent.left
                top: parent.top
                leftMargin: 4
                topMargin: 4
            }
            onClicked: {
                setTitle(componentsMgr.comps[gridView.currentIndex]["name"])
                hideComp();
            }
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
    SequentialAnimation {
        id: showCompAni
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
            target: compLoader
            property : "opacity"
            to: 1
            duration: 240
        }
    }
    SequentialAnimation {
        id: hideCompAni
        NumberAnimation {
            target: compLoader
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
    function showDetail(index) {
        gridView.currentIndex = index
        showDetailAni.start()
    }
    function hideDetail() {
        gridView.currentIndex = -1
        hideDetailAni.start()
    }
    function showComp(compPath) {
        compLoader.source = compPath
        showCompAni.start()
    }
    function hideComp() {
        compLoader.source = ""
        hideCompAni.start()
    }
    function setTitle(title) {
        titleText.title = title
    }
}
