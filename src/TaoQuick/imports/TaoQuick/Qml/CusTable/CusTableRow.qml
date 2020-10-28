import QtQuick 2.9
import QtQuick.Controls 2.2
import "."
import ".."
import "../.."

Rectangle {
    id: deviceRow
    height: visible ? CusConfig.fixedHeight : 0
    visible: dataObj["isVisible"]

    property bool isSelected: dataObj["isSelected"]
    property bool isChecked: dataObj["isChecked"]
    property bool isAlternate: dataObj["isAlternate"]
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
    color: isSelected ? CusConfig.controlColor_pressed : ( isAlternate ? CusConfig.controlColor : Qt.darker(CusConfig.controlColor, 1.1) )
    Item {
        id: checkBoxItem
        width: widthList[0]
        height: parent.height

        CusCheckBox {
            id: checkBox
            anchors.verticalCenter: parent.verticalCenter
            x: 6
            height: 24
            width: height
            property bool notify: true
            onCheckedChanged: {
                if(notify) {
                    deviceRow.checkedChanged(checked)
                }
            }
        }
    }
    Repeater {
        model: roles
        Item {
            id: columnItem
            x: xList[index + 1]
            width: widthList[index + 1]
            height: parent.height
            CusLabel {
                id: textLabel
                text: qsTr(String(dataObj[roles[index]])) + CusConfig.transString
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: textColor
            }
        }
    }
}
