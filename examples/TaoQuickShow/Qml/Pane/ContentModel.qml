import QtQuick 2.0
import QtQml.Models 2.1
ListModel {
    id: demoModel
    ListElement {
        name: "Label"
        source: "General/Labels.qml"
        visible: true
        group: "General"
        groupOpen: true
    }
    ListElement {
        name: "Image"
        source: "General/Images.qml"
        visible: true
        group: "General"
        groupOpen: true
    }
    ListElement {
        name: "Button"
        source: "General/Buttons.qml"
        visible: true
        group: "General"
        groupOpen: true
    }
    ListElement {
        name: "Data Entry"
        source: "General/DataEntrys.qml"
        visible: true
        group: "General"
        groupOpen: true
    }
    ListElement {
        name: "Table"
        source: "General/Tables.qml"
        visible: true
        group: "General"
        groupOpen: true
    }
    ListElement {
        name: "Drag Rect"
        source: "General/Drags.qml"
        visible: true
        group: "General"
        groupOpen: true
    }

    ListElement {
        name: "Others"
        source: "General/Miscs.qml"
        visible: true
        group: "General"
        groupOpen: true
    }
    ListElement {
        name: "Enter"
        source: "Animation/Enter.qml"
        visible: true
        group: "Animation"
        groupOpen: true
    }
    ListElement {
        name: "Grad"
        source: "Animation/Grad.qml"
        visible: true
        group: "Animation"
        groupOpen: true
    }
    ListElement {
        name: "Cleavage"
        source: "Animation/Cleavage.qml"
        visible: true
        group: "Animation"
        groupOpen: true
    }
    ListElement {
        name: "Diagonal"
        source: "Animation/Diagonal.qml"
        visible: true
        group: "Animation"
        groupOpen: true
    }
    ListElement {
        name: "Louver"
        source: "Animation/Louver.qml"
        visible: true
        group: "Animation"
        groupOpen: true
    }
    ListElement {
        name: "Square"
        source: "Animation/Square.qml"
        visible: true
        group: "Animation"
        groupOpen: true
    }
    ListElement {
        name: "Circle"
        source: "Animation/Circle.qml"
        visible: true
        group: "Animation"
        groupOpen: true
    }
    ListElement {
        name: "Cross"
        source: "Animation/Cross.qml"
        visible: true
        group: "Animation"
        groupOpen: true
    }
    ListElement {
        name: "Rhombus"
        source: "Animation/Rhombus.qml"
        visible: true
        group: "Animation"
        groupOpen: true
    }
    ListElement {
        name: "Wheel"
        source: "Animation/Wheel.qml"
        visible: true
        group: "Animation"
        groupOpen: true
    }

    ListElement {
        name: "Board"
        source: "Animation/Board.qml"
        visible: true
        group: "Animation"
        groupOpen: true
    }
    ListElement {
        name: "Dissolve"
        source: "Animation/Dissolve.qml"
        visible: true
        group: "Animation"
        groupOpen: true
    }



    ListElement {
        name: "FadeInOut"
        source: "PageSwitch/FadeInOut.qml"
        visible: true
        group: "PageSwitch"
        groupOpen: true
    }
    ListElement {
        name: "Grad"
        source: "PageSwitch/Grad.qml"
        visible: true
        group: "PageSwitch"
        groupOpen: true
    }
    ListElement {
        name: "Cleavage"
        source: "PageSwitch/Cleavage.qml"
        visible: true
        group: "PageSwitch"
        groupOpen: true
    }
    ListElement {
        name: "Diagonal"
        source: "PageSwitch/Diagonal.qml"
        visible: true
        group: "PageSwitch"
        groupOpen: true
    }
    ListElement {
        name: "Louver"
        source: "PageSwitch/Louver.qml"
        visible: true
        group: "PageSwitch"
        groupOpen: true
    }
    ListElement {
        name: "Square"
        source: "PageSwitch/Square.qml"
        visible: true
        group: "PageSwitch"
        groupOpen: true
    }
    ListElement {
        name: "Circle"
        source: "PageSwitch/Circle.qml"
        visible: true
        group: "PageSwitch"
        groupOpen: true
    }
    ListElement {
        name: "Cross"
        source: "PageSwitch/Cross.qml"
        visible: true
        group: "PageSwitch"
        groupOpen: true
    }
    ListElement {
        name: "Rhombus"
        source: "PageSwitch/Rhombus.qml"
        visible: true
        group: "PageSwitch"
        groupOpen: true
    }
    ListElement {
        name: "Wheel"
        source: "PageSwitch/Wheel.qml"
        visible: true
        group: "PageSwitch"
        groupOpen: true
    }

    ListElement {
        name: "Board"
        source: "PageSwitch/Board.qml"
        visible: true
        group: "PageSwitch"
        groupOpen: true
    }
    ListElement {
        name: "Dissolve"
        source: "PageSwitch/Dissolve.qml"
        visible: true
        group: "PageSwitch"
        groupOpen: true
    }

    ListElement {
        name: "Magic Circle"
        source: "Effect/ARound.qml"
        visible: true
        group: "Effect"
        groupOpen: true
    }
    ListElement {
        name: "Undercurrent surge"
        source: "Effect/Arrow.qml"
        visible: true
        group: "Effect"
        groupOpen: true
    }
    ListElement {
        name: "Ring"
        source: "Effect/RingPage.qml"
        visible: true
        group: "Effect"
        groupOpen: true
    }
    ListElement {
        name: "Keep up with the pace"
        source: "Effect/SoundByte.qml"
        visible: true
        group: "Effect"
        groupOpen: true
    }
//    ListElement {
//        name: "Brilliant Starry Sky"
//        source: "Effect/Swapper.qml"
//        visible: true
//        group: "Effect"
//        groupOpen: true
//    }


    ListElement {
        name: "Super Mario"
        source: "ShaderEffect/SuperMario.qml"
        visible: true
        group: "ShaderEffect"
        groupOpen: true
    }
    ListElement {
        name: "Snail"
        source: "ShaderEffect/Snail.qml"
        visible: true
        group: "ShaderEffect"
        groupOpen: true
    }
    ListElement {
        name: "Brilliant Starry Sky"
        source: "ShaderEffect/Planet.qml"
        visible: true
        group: "ShaderEffect"
        groupOpen: true
    }
    ListElement {
        name: "CloudHole"
        source: "ShaderEffect/CloudHole.qml"
        visible: true
        group: "ShaderEffect"
        groupOpen: true
    }
    function updateSection(section, isOpen) {
        for (var i = 0; i < count; ++i) {
            var obj = get(i)
            if (obj["group"] === section) {
                setProperty(i, "groupOpen", isOpen)
            }
        }
    }
    function search(text) {
        var i = 0
        if (text.length <= 0) {
            for ( i = 0; i < count; ++i) {
                setProperty(i, "visible", true)
            }
        } else {
            var lowerText = String(text).toLowerCase()
            for (i = 0; i < count; ++i) {
                var obj = get(i)
                if (qsTr(obj["name"]).toLowerCase().indexOf(lowerText) >= 0) {
                    setProperty(i, "visible", true)
                } else {
                    setProperty(i, "visible", false)
                }
            }
        }
    }
}
