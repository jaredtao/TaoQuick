import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

import "."
import ".."
import "../.."

Rectangle {
    id: cusTableRow
    height: visible ? CusConfig.fixedHeight : 0

    property bool isSelected: dataObj ? dataObj["isSelected"] : false
    property bool isChecked: dataObj ? dataObj["isChecked"] : false
    property bool isAlternate: dataObj ? dataObj["isAlternate"] : false
    onIsCheckedChanged: {
        checkBox.notify = false
        checkBox.checked = isChecked
        checkBox.notify = true
    }
    property var dataObj
    property var widthList
    property var xList
    property var roles
    property color textColor: CusConfig.textColor

    signal checkedChanged(bool checked)
    color: isSelected ? CusConfig.controlColor_pressed : ( isAlternate ? CusConfig.controlColor : Qt.lighter(CusConfig.controlColor, 1.1) )
    Item {
        id: checkBoxItem
        width: widthList[0]
        height: parent.height

        CusCheckBox {
            id: checkBox
            anchors.verticalCenter: parent.verticalCenter
            x: 6
            height: 20
            width: height
            indicator.width: 20
            indicator.height: 20
            property bool notify: true
            onCheckedChanged: {
                if(notify) {
                    cusTableRow.checkedChanged(checked)
                }
            }
        }
    }
    Repeater {
        model: roles
        Loader {
            x: xList ? xList[index + 1] : 0
            width: widthList ? widthList[index + 1] : 0
            height: parent.height
            asynchronous: true
            sourceComponent: Item {
                anchors.fill: parent
                CusLabel {
                    text: dataObj ? (qsTr(String(dataObj[roles[index]])) + CusConfig.transString) : ""
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: CusConfig.fontSize_tableContent
                    color: textColor
                }
            }
        }

    }
}
