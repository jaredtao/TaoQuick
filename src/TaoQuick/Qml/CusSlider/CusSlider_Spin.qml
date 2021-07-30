import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."
Row {
    height: CusConfig.fixedHeight
    spacing: 0
    property alias value: slider.value
    property alias from: slider.from
    property alias to: slider.to
    property alias stepSize: slider.stepSize
    CusSlider {
        id: slider
        height: CusConfig.fixedHeight
        width: parent.width * 0.8
        onValueChanged: {
            spinBox.value = value
        }
    }
    CusSpinBox {
        id: spinBox
        height: CusConfig.fixedHeight
        width: parent.width * 0.2
        value: slider.value
        from: slider.from
        to: slider.to
        onValueChanged: {
            slider.value = value
        }
    }
}
