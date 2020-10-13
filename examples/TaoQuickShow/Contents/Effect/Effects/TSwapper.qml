import QtQuick 2.9
import QtQuick.Controls 2.2
Item {
    id: r
    property url source

    Image {
        id: img1
        anchors.fill: parent
        source: r.source
        opacity: 1
    }
    Image {
        id: img2
        anchors.fill: parent
        source: r.source
        opacity: 0.5
        rotation: 180
    }

    SequentialAnimation {
        running: true
        loops: Animation.Infinite

        PauseAnimation {
            duration: 5 * 1000
        }
        ParallelAnimation {
            NumberAnimation { target: img1; property:"opacity"; to: 0.5; duration: 1000 }
            NumberAnimation { target: img2; property:"opacity"; to: 1; duration: 1000 }
        }

        PauseAnimation {
            duration: 5 * 1000
        }
        ParallelAnimation {
            NumberAnimation { target: img1; property:"opacity";  to: 1; duration: 1000 }
            NumberAnimation { target: img2; property:"opacity";  to: 0.5; duration: 1000 }
        }
    }
}
