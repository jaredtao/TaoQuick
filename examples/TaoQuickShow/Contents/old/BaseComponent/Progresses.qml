import QtQuick 2.9
import QtQuick.Controls 2.2

import TaoQuick 1.0


Item {
    id: r
    anchors.fill: parent
    Grid {
        id: g
        anchors.fill: parent
        anchors.margins: 10
        columns: 2
        spacing: 10
        Column {
            width: g.width / 2 - 10
            height: g.height /2 - 10
            spacing: 10
            TNormalProgress {
                width: parent.width
                backgroundColor: gConfig.reserverColor
                NumberAnimation on percent { from: 0; to: 100; duration: 5000; running: true; loops: Animation.Infinite}
            }
            TNormalProgress {
                width: parent.width
                backgroundColor: gConfig.reserverColor
                flicker: true
                percent: 50
            }
            TNormalProgress {
                width: parent.width
                backgroundColor: gConfig.reserverColor
                barType: TNormalProgress.BarType.SucceedOrFailed
                percent: 70
            }
            TNormalProgress {
                width: parent.width
                backgroundColor: gConfig.reserverColor
                barType: TNormalProgress.BarType.SucceedOrFailed
                percent: 100
            }
            TNormalProgress {
                width: parent.width
                backgroundColor: gConfig.reserverColor
                barType: TNormalProgress.BarType.NoBar
                percent: 50
                gradientIndex: 12
            }
        }
        Row {
            width: g.width / 2 - 10
            height: g.height /2 - 10
            spacing: 10

            TCircleProgress {
                width: 120
                height: 120
                backgroundColor: gConfig.reserverColor
                NumberAnimation on percent { from: 0; to: 100; duration: 5000; running: true; loops: Animation.Infinite}
            }
            TCircleProgress {
                width: 120
                height: 120
                backgroundColor: gConfig.reserverColor
                barType: TNormalProgress.BarType.SucceedOrFailed
                percent: 75
            }
            TCircleProgress {
                width: 120
                height: 120
                backgroundColor: gConfig.reserverColor
                barType: TNormalProgress.BarType.SucceedOrFailed
                percent: 100
            }
        }
        Row {
            width: g.width / 2 - 10
            height: g.height /2 - 10
            spacing: 10

            TCircleProgress {
                width: 120
                height: 120
                backgroundColor: gConfig.reserverColor
                text: String("%1天").arg(percent)
                NumberAnimation on percent { from: 0; to: 100; duration: 5000; running: true; loops: Animation.Infinite}
            }
            TCircleProgress {
                id: ppppp
                width: 120
                height: 120
                backgroundColor: gConfig.reserverColor
                barType: TNormalProgress.BarType.SucceedOrFailed
                SequentialAnimation {
                    running: true
                    loops: Animation.Infinite
                    NumberAnimation {
                        target: ppppp
                        property: "percent"
                        from: 0
                        to: 100
                        duration: 3000
                    }
                    PauseAnimation {
                        duration: 500
                    }
                }
            }
            TCircleProgress {
                width: 120
                height: 120
                backgroundColor: gConfig.reserverColor
                percent: 100
            }
        }
        Column {
            width: g.width / 2 - 10
            height: g.height /2 - 10
            spacing: 10
        }
        Column {
            width: g.width / 2 - 10
            height: g.height /2 - 10
            spacing: 10
        }
    }

}
