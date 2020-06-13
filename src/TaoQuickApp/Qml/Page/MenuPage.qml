import QtQuick 2.12
import QtQuick.Controls 2.12
import TaoQuick 1.0
import "qrc:/TaoQuick"
ListView {
    id: root
    anchors.fill: parent
    property string currentTitle
    property string currentUrl
    property int rowHeight: 40
    clip: true
    onModelChanged: {
        var f = model.get(0)
        currentTitle = f.name
        currentUrl = f.url
        mainIndex = 0
    }
    property var mainIndex: -1
    property var subIndex: -1
    delegate: Item {
        id: delegateItem
        width: root.width
        height: rowHeight
        clip: true
        Behavior on height {
            NumberAnimation { duration: 200 }
        }
        TGradientBtn {
            id: btn
            width: root.width
            height: rowHeight
            text: trans.trans(model.name) + trans.transString
            textItem.leftPadding: 6
            textHorizontalAlignment: Text.AlignLeft
            textColor: text === currentTitle ? gConfig.titleBackground : gConfig.textColor
            onClicked: {
                if (model.url)
                {
                    currentTitle = model.name
                    currentUrl = model.url
                } else {
                    if (!subListView.initOnce) {
                        var subData = model.children
                        subListView.model = subData
                        subListView.initOnce = true;
                    }
                    if (subListView.visible)
                    {
                        subListView.visible = false
                        delegateItem.height = rowHeight
                    } else {
                        delegateItem.height =subListView.height + rowHeight
                        subListView.visible = true
                    }
                }
                mainIndex = index
                subIndex = -1
            }
        }
        ListView {
            id: subListView
            visible: false
            x: 20
            y: rowHeight
            width: root.width
            height: count * rowHeight
            property bool initOnce: false
            delegate: TGradientBtn {
                width: root.width
                height: rowHeight
                text: trans.trans(model.name) + trans.transString
                textColor: text === currentTitle ? gConfig.titleBackground : gConfig.textColor
                onClicked: {
                    currentTitle = model.name
                    currentUrl = model.url
                    subIndex = index
                }
            }
        }
    }
}
