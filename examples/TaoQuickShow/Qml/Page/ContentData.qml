import QtQuick 2.12
QtObject {

//    property color titleBackground: "#c62f2f"
//    property color background: "#f6f6f6"
//    property color reserverColor: "#ffffff"
//    property color textColor: "black"
//    property color splitColor: "gray"

    property color titleBackground: themes.get(0).titleBackground
    property color background: themes.get(0).background
    property color textColor: themes.get(0).textColor
    property color reserverColor: "#ffffff"
    property color splitColor: "gray"

    property int currentTheme: 0
    onCurrentThemeChanged: {
        var t = themes.get(currentTheme)
        titleBackground = t.titleBackground
        background = t.background
        textColor = t.textColor
    }
    property ListModel themes: ListModel {
        ListElement {
            name: "Red"
            titleBackground: "#c62f2f"
            background: "#f6f6f6"
            textColor: "#5c5c5c"
        }
        ListElement {
            name: "Black"
            titleBackground: "#222225"
            background: "#272c25"
            textColor: "#adafb2"
        }
        ListElement {
            name: "Pink"
            titleBackground: "#faa0c5"
            background: "#f6f6f6"
            textColor: "#5c5c5c"
        }
        ListElement {
            name: "Gold"
            titleBackground: "#fed98f"
            background: "#f6f6f6"
            textColor: "#5c5c5c"
        }
        ListElement {
            name: "Green"
            titleBackground: "#58c979"
            background: "#f6f6f6"
            textColor: "#5c5c5c"
        }
        ListElement {
            name: "Blue"
            titleBackground: "#67c1fd"
            background: "#f6f6f6"
            textColor: "#5c5c5c"
        }
    }

    property ListModel contentData: ListModel {
        ListElement { name: "Home"; url: ""; children: []}
    }
}
