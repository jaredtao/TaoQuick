import QtQml 2.2
import QtQuick 2.9

ThemeData {
    themeName: qsTr("Red")

    themeColor: "#c62f2f"

    backgroundColor: "#f6f6f6"
    backgroundBorderColor: Qt.darker(backgroundColor, 1.6)

    splitLineColor: "#a82828"
    textColor: "#5c5c5c"
    textColor_disabled: Qt.lighter(textColor, 1.8)
    textColor_highlighted: Qt.darker(textColor, 1.4)
    textColor_hovered: Qt.darker(textColor, 1.2)

    //    controlInvalidColor
    controlBackgroundColor: Qt.darker(backgroundColor, 1.35)
    controlBackgroundColor_selected: Qt.lighter(controlBackgroundColor, 1.1)
    controlBackgroundColor_disabled: Qt.darker(controlBackgroundColor, 1.8)
    controlBackgroundColor_highlighted: Qt.lighter(controlBackgroundColor, 1.2)
    controlBackgroundColor_hovered: Qt.lighter(controlBackgroundColor, 1.3)

    //    controlBorderColor
    //    controlBorderColor_hovered

    //    alterColor

    //    scrollBarBackgroundColor
    tipBackgroundColor: Qt.darker(backgroundColor, 1.1)
    tipBorderColor: Qt.darker(backgroundColor, 3.0)
    tipTextColor: textColor
}
