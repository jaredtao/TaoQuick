import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."
Row {
    height: Config.fixedHeight
    spacing: 0
    property alias value: slider.value
    property alias from: slider.from
    property alias to: slider.to
    property alias stepSize: slider.stepSize
    CusSlider {
        id: slider
        height: Config.fixedHeight
        width: parent.width * 0.88
        onValueChanged: {
            spinBox.value = value
        }
    }
    CusSpinBox {
        id: spinBox
        height: Config.fixedHeight
        width: parent.width * 0.12
        value: slider.value
        from: slider.from
        to: slider.to
        onValueChanged: {
            slider.value = value
        }
    }
}
