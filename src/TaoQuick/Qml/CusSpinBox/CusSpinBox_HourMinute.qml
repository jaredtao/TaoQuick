import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."

Row {
    id: cusSpinBoxHourMinute
    property int hour: 0
    property int minute: 0
    property int defaultSpinWidth: 60
    width: childrenRect.width
    spacing: 2

    onHourChanged: {
        hourSpin.value = hour
    }
    onMinuteChanged: {
        minuteSpin.value = minute
    }
    function prefixZero(value, locale) {
        return String((value < 10 ? "0" : "") + String(value))
    }
    CusSpinBox {
        id: hourSpin
        from: 0
        to: 23
        enabled: cusSpinBoxHourMinute.enabled
        onValueChanged: {
            cusSpinBoxHourMinute.hour = value
        }
        implicitWidth: defaultSpinWidth
        textFromValue: prefixZero
    }
    CusLabel {
        text: ":"
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        width: 4
    }
    CusSpinBox {
        id: minuteSpin
        from: 0
        to: 59
        onValueChanged: {
            cusSpinBoxHourMinute.minute = value
        }
        enabled: cusSpinBoxHourMinute.enabled
        implicitWidth: defaultSpinWidth
        textFromValue: prefixZero
    }
}
