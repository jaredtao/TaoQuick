import QtQuick 2.0

ListModel {
    id: demoModel
    ListElement {
        name: "Label"
        source: "General/Labels.qml"
    }
    ListElement {
        name: "Image"
        source: "General/Images.qml"
    }
    ListElement {
        name: "Button"
        source: "General/Buttons.qml"
    }

    ListElement {
        name: "Switch"
    }
    ListElement {
        name: "CheckBox"
    }
    ListElement {
        name: "ComboBox"
    }
    ListElement {
        name: "Input"
    }

    ListElement {
        name: "Popup"
    }
    ListElement {
        name: "Popup"
    }
    ListElement {
        name: "BusyIndicator"
    }
}
