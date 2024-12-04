import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

CusButton {
    backgroundColorNormal: "#ffffff"
    backgroundColorHovered: "#eaf6fd"
    backgroundColorPressed: "#d7ebfa"
    backgroundColorDisable: "#b6bdc5"

    borderColor: enabled ? "#38a9e4" : "#b6bdc5"
    borderWidth: 1

    textColor: enabled ? "#38a9e4" : "#ffffff"
}
