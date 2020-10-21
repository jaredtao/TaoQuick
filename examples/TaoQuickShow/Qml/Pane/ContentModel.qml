import QtQuick 2.0

ListModel {
    id: demoModel
    ListElement {
        name: "Label"
        source: "Labels.qml"
    }
    ListElement {
        name: "Image"
        source: "Images.qml"
    }
    ListElement {
        name: "Button"
        source: "Buttons.qml"
    }

    ListElement {
        name: "Data Entry"
        source: "DataEntrys.qml"
    }
    ListElement {
        name: "Drag Rect"
        source: "Drags.qml"
    }

    ListElement {
        name: "Misc"
        source: "Miscs.qml"
    }
}
