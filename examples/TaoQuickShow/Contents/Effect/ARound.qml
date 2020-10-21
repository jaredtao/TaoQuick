import QtQuick 2.9
import QtQuick.Controls 2.2
import "./Effects"
Item {
    anchors.fill: parent

    TAround {
        id: around
        width: 400
        height: 400
        anchors.centerIn: parent
        wave: waveSlider.value
        speed: speedSlider.value
        ringWidth: ringWidthSlider.value / 100.0
        rotationSpeed: (rotationSpeedSlider.value - 50.0) / 5.0
        holeSmooth: holeSmoothSlider.value / 100
        holeSize: holeSizeSlider.value / 100
        colorSaturation: colorSaturationSlider.value / 100
        colorValue: colorValueSlider.value / 200
    }
    Column {
        Row {
            Text {
                text: "wave " + around.wave.toFixed(2)
                anchors.verticalCenter: parent.verticalCenter
                color: "black"
            }
            Slider {
                id: waveSlider
                from: 1
                to: 100
                value: 80
            }
        }
        Row {
            Text {
                text: "speed " + around.speed.toFixed(2)
                anchors.verticalCenter: parent.verticalCenter
                color: "black"
            }
            Slider {
                id: speedSlider
                from: 1
                to: 32
                value: 6
            }
        }
        Row {
            Text {
                text: "ringWidth " + around.ringWidth.toFixed(2)
                anchors.verticalCenter: parent.verticalCenter
                color: "black"
            }
            Slider {
                id: ringWidthSlider
                from: 0
                to: 100
                value: 80
            }
        }
        Row {
            Text {
                text: "rotationSpeed" + around.rotationSpeed.toFixed(2)
                anchors.verticalCenter: parent.verticalCenter
                color: "black"
            }
            Slider {
                id: rotationSpeedSlider
                from: 0
                to: 100
                value: 55
            }
        }
        Row {
            Text {
                text: "holeSize" + around.holeSize.toFixed(2)
                anchors.verticalCenter: parent.verticalCenter
                color: "black"
            }
            Slider {
                id: holeSizeSlider
                from: 0
                to: 100
                value: 15
            }
        }
        Row {
            Text {
                text: "holeSmooth" + around.holeSmooth.toFixed(2)
                anchors.verticalCenter: parent.verticalCenter
                color: "black"
            }
            Slider {
                id: holeSmoothSlider
                from: 0
                to: 100
                value: 44
            }
        }
        Row {
            Text {
                text: "colorValue" + around.colorValue.toFixed(2)
                anchors.verticalCenter: parent.verticalCenter
                color: "black"
            }
            Slider {
                id: colorValueSlider
                from: 0
                to: 200
                value: 100
            }
        }
        Row {
            Text {
                text: "colorSaturation" + around.colorSaturation.toFixed(2)
                anchors.verticalCenter: parent.verticalCenter
                color: "black"
            }
            Slider {
                id: colorSaturationSlider
                from: 0
                to: 100
                value: 100
            }
        }
    }
}
