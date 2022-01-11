import QtQml 2.0
import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Particles 2.0

import TaoQuick  1.0
Item {
    id: atomJoggle

    property var targetWin: null
    property Item targetEdit: null
    function joggle(duration, intensity) {
        emitter.enabled = true

        joggleAnimation.pos = Qt.point(targetWin.x, targetWin.y)
        joggleAnimation.dur = duration
        joggleAnimation.intensity = intensity

        joggleAnimation.start()
    }
    SequentialAnimation {
        id: joggleAnimation
        property point pos: Qt.point(0, 0)
        property int intensity: 10
        property int dur: 10
        ParallelAnimation {
            NumberAnimation {
                target: targetWin
                property: "x"
                to: joggleAnimation.pos.x + (Math.random() < 0.5 ? -1 : 1) * joggleAnimation.intensity
                duration: joggleAnimation.dur
            }
            NumberAnimation {
                target: targetWin
                property: "y"
                to: joggleAnimation.pos.y + (Math.random() < 0.5 ? -1 : 1) * joggleAnimation.intensity
                duration: joggleAnimation.dur
            }
        }
        ParallelAnimation {
            NumberAnimation {
                target: targetWin
                property: "x"
                to: joggleAnimation.pos.x
                duration: joggleAnimation.dur
            }
            NumberAnimation {
                target: targetWin
                property: "y"
                to: joggleAnimation.pos.y
                duration: joggleAnimation.dur
            }
        }
    }
    ParticleSystem {
        id: sys
    }
    ImageParticle {
        system: sys
        source: CusConfig.imagePathPrefix + "particle.png"
        colorVariation: 1.0
        alpha: 0.1
    }
    Emitter {
        id: emitter
        x: targetEdit.cursorRectangle.x
        y: targetEdit.cursorRectangle.y
        system: sys
        emitRate: 40
        lifeSpan: 300
        lifeSpanVariation: 100
        size: 12
        endSize: 6
        velocity: AngleDirection {
            angleVariation: 360
            magnitude: 60
        }
        enabled: false
        onEnabledChanged: {
            if (enabled) {
                timer.start()
            }
        }
    }
    Timer {
        id: timer
        interval: 500
        repeat: false
        running: false
        onTriggered: {
            emitter.enabled = false
        }
    }
}
