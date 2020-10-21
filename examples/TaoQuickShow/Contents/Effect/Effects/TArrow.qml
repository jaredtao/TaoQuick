import QtQuick 2.9
import QtQuick.Controls 2.2
Image {
    id: root
    x: 10
    y: 10
    source: imgPath + "Effect/arrow.png"
    visible: false
    function run() {
        visible = true;
        pathAnimation.start();
    }
    PathAnimation {
        id: pathAnimation
        target: root
        loops: -1
        duration: 2400
        orientation: PathAnimation.TopFirst
        path: Path{
            startX: 10
            startY: 10
            PathCurve { x: 60; y: 15}
            PathCurve { x: 110; y: 205}
            PathCurve { x: 210; y: 200}
            PathCurve { x: 260; y: 35}
            PathCurve { x: 310; y: 25}
        }
    }
}
