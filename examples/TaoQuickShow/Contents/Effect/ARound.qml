import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0
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
            BasicText {
                text: "wave " + around.wave.toFixed(2)
                anchors.verticalCenter: parent.verticalCenter
                color: "black"
                width: 200
            }
            CusSlider {
                id: waveSlider
                from: 1
                to: 100
                value: 80
            }
        }
        Row {
            BasicText {
                text: "speed " + around.speed.toFixed(2)
                anchors.verticalCenter: parent.verticalCenter
                color: "black"
                width: 200
            }
            CusSlider {
                id: speedSlider
                from: 1
                to: 32
                value: 6
            }
        }
        Row {
            BasicText {
                text: "ringWidth " + around.ringWidth.toFixed(2)
                anchors.verticalCenter: parent.verticalCenter
                color: "black"
                width: 200
            }
            CusSlider {
                id: ringWidthSlider
                from: 0
                to: 100
                value: 80
            }
        }
        Row {
            BasicText {
                text: "rotationSpeed" + around.rotationSpeed.toFixed(2)
                anchors.verticalCenter: parent.verticalCenter
                color: "black"
                width: 200
            }
            CusSlider {
                id: rotationSpeedSlider
                from: 0
                to: 100
                value: 55
            }
        }
        Row {
            BasicText {
                text: "holeSize" + around.holeSize.toFixed(2)
                anchors.verticalCenter: parent.verticalCenter
                color: "black"
                width: 200
            }
            CusSlider {
                id: holeSizeSlider
                from: 0
                to: 100
                value: 15
            }
        }
        Row {
            BasicText {
                text: "holeSmooth" + around.holeSmooth.toFixed(2)
                anchors.verticalCenter: parent.verticalCenter
                color: "black"
                width: 200
            }
            CusSlider {
                id: holeSmoothSlider
                from: 0
                to: 100
                value: 44
            }
        }
        Row {
            BasicText {
                text: "colorValue" + around.colorValue.toFixed(2)
                anchors.verticalCenter: parent.verticalCenter
                color: "black"
                width: 200
            }
            CusSlider {
                id: colorValueSlider
                from: 0
                to: 200
                value: 100
            }
        }
        Row {
            BasicText {
                text: "colorSaturation" + around.colorSaturation.toFixed(2)
                anchors.verticalCenter: parent.verticalCenter
                color: "black"
                width: 200
            }
            CusSlider {
                id: colorSaturationSlider
                from: 0
                to: 100
                value: 100
            }
        }
    }
}
