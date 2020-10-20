import QtQuick 2.0

ListModel {
    id: demoModel
    ListElement {
        name: "Button"
        source: "General/Buttons.qml"
    }
    ListElement {
        name: "Image"
        source: "General/Images.qml"
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
        name: "Label"
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
