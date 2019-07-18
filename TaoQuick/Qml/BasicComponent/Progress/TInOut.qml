import QtQuick 2.12
import QtQuick.Controls 2.12
Item {
    width: 400
    height: 400

    property var colors: [
        "#a93190",
        "#c13fa6",
        "#d64172",
        "#e44e48",
        "#f25650",
        "#f57241",
        "#f47032",
        "#ff9329",
        "#ff9b38",
        "#ffc101",
        "#ffd103",
        "#ffde00",
        "#4ee366",
        "#4bf49a",
        "#4ef4c3",
        "#51c2f8",
        "#43b0e7",
        "#32a0d6",
        "#ffffff"
    ]

    property real maxDistance: 100
    property vector2d originPos: Qt.vector2d(big.x + big.width / 2, big.y + big.height / 2)
    property vector2d targetPos
    property int angle

    Rectangle {
        id: big
        width: 40
        height: width
        radius: width / 2
        color: Qt.lighter(colors[0])
        anchors.centerIn: parent
    }
    Rectangle {
        id: small
        width: 10
        height: width
        radius: width / 2
        color: {
            let p = small.mapToItem(big, small.x, small.y)
            return big.contains(Qt.point(p.x, p.y)) ? big.color : colors[5]
        }
        Component.onCompleted: {
            x = originPos.x
            y = originPos.y
        }
        SequentialAnimation {
            running: true
            loops: Animation.Infinite
            ScriptAction {
                script: {
                    angle = getRandomArbitrary(0, 360)

                    let x = originPos.x + maxDistance * Math.cos(degreeToRadians(angle))
                    let y = originPos.y + maxDistance * Math.sin(degreeToRadians(angle))
                    targetPos = Qt.vector2d(x, y)
                    console.log(targetPos)
                }
            }
            ParallelAnimation {
                NumberAnimation { target: small; easing.type: Easing.InExpo; property:"x"; to: targetPos.x; duration: 800; }
                NumberAnimation { target: small; easing.type: Easing.InExpo; property:"y"; to: targetPos.y; duration: 800; }
            }

            PauseAnimation { duration: 200}
            ParallelAnimation {
                NumberAnimation { target: small; easing.type: Easing.InExpo; property:"x"; to: originPos.x; duration: 800; }
                NumberAnimation { target: small; easing.type: Easing.InExpo; property:"y"; to: originPos.y; duration: 800; }
            }
        }
    }

    //得到一个两数之间的随机数 [min, max)
    function getRandomArbitrary(min, max) {
        return Math.random() * (max - min) + min;
    }
    //得到一个两数之间的随机整数 [min↑, max↓)
    function getRandomInt(min, max) {
        min = Math.ceil(min);
        max = Math.floor(max);
        return Math.floor(Math.random() * (max - min)) + min; //不含最大值，含最小值
    }
    //得到一个两数之间的随机整数，包括两个数在内 [min↑, max↓)
    function getRandomIntInclusive(min, max) {
        min = Math.ceil(min);
        max = Math.floor(max);
        return Math.floor(Math.random() * (max - min + 1)) + min; //含最大值，含最小值
    }
    function degreeToRadians(angle) {
        return angle / 360 * Math.PI
    }
    function radiansToDegree(radians) {
        return radians / Math.PI * 360
    }

}
