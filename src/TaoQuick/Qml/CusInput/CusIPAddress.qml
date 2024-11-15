import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."

Rectangle {
    id: control

    implicitHeight: CusConfig.fixedHeight
    implicitWidth: 160
    
    border.width: 1
    border.color: enabled && (transArea.containsMouse ||input1.focus || input2.focus || input3.focus || input4.focus) ? CusConfig.controlBorderColor_hovered : CusConfig.controlBorderColor
    radius: CusConfig.controlBorderRadius
    color: enabled ? CusConfig.controlColor : CusConfig.controlColor_disabled

    readonly property int paddingW: 4
    readonly property int dotW: 4
    readonly property int spacingW: 1
    property int inputW: (width - dotW * 3 - 6 * spacingW - paddingW * 2) / 4

    property string ipAddr: input1.text + "." + input2.text + "." + input3.text + "." + input4.text
    property bool isValid: input1.displayText.length > 0 && input2.displayText.length > 0
                           && input3.displayText.length > 0 && input4.displayText.length > 0

    function inputIP(ipAddr) {
        var list = ipAddr.split('.');
        if (list.length === 4) {
            input1.text = list[0]
            input2.text = list[1]
            input3.text = list[2]
            input4.text = list[3]
        }
    }
    Row {
        x: control.paddingW
        width: control.width - control.paddingW * 2
        height: control.height
        spacing: control.spacingW

      CusTextInput {
            id: input1
            height: parent.height
            width: control.inputW
            focus: true
            activeFocusOnTab: true
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            anchors.verticalCenter: parent.verticalCenter
            validator: RegExpValidator{
                regExp: /^(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])$/
            }
            KeyNavigation.right: input2
            onTextChanged: {
                if (text.length >= 3) {
                    input2.focus = true
                }
            }
        }
        Label {
            text: "."
            height: parent.height
            width: control.dotW
            verticalAlignment: Qt.AlignBottom
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -8
        }
        CusTextInput {
            id: input2
            height: parent.height
            width: control.inputW
            activeFocusOnTab: true
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            anchors.verticalCenter: parent.verticalCenter
            validator: RegExpValidator{
                regExp: /^(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])$/
            }
            KeyNavigation.backtab: input1
            KeyNavigation.tab: input3
            KeyNavigation.left: input1
            KeyNavigation.right: input3
            onTextChanged: {
                if (text.length >= 3) {
                    input3.focus = true
                }
            }
            Keys.enabled: true
            Keys.onPressed: function (event) {
                switch (event.key) {
                case Qt.Key_Backspace:
                {
                    if (focus && text.length <= 0) {
                        input1.focus = true
                    }
                }
                }
            }
        }
        Label {
            text: "."
            height: parent.height
            width: control.dotW
            verticalAlignment: Qt.AlignBottom
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -8
        }
        CusTextInput {
            id: input3
            height: parent.height
            width: control.inputW
            activeFocusOnTab: true
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            anchors.verticalCenter: parent.verticalCenter

            validator: RegExpValidator{
                regExp: /^(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])$/
            }
            KeyNavigation.backtab: input2
            KeyNavigation.tab: input4
            KeyNavigation.left: input2
            KeyNavigation.right: input4
            onTextChanged: {
                if (text.length >= 3) {
                    input4.focus = true
                }
            }
            Keys.enabled: true
            Keys.onPressed: function (event) {
                switch (event.key) {
                case Qt.Key_Backspace:
                {
                    if (focus && text.length <= 0) {
                        input2.focus = true
                    }
                }
                }
            }
        }
        Label {
            text: "."
            height: parent.height
            width: control.dotW
            verticalAlignment: Qt.AlignBottom
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -8
        }
        CusTextInput {
            id: input4
            height: parent.height
            width: control.inputW
            activeFocusOnTab: true
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            anchors.verticalCenter: parent.verticalCenter
            validator: RegExpValidator{
                regExp: /^(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])$/
            }
            KeyNavigation.backtab: input3
            KeyNavigation.left: input3
            Keys.enabled: true
            Keys.onPressed: function (event) {
                switch (event.key) {
                case Qt.Key_Backspace:
                {
                    if (focus && text.length <= 0) {
                        input3.focus = true
                    }
                }
                }
            }
        }
    }
    TransArea {
        id: transArea
        cursorShape: Qt.IBeamCursor
    }
}
