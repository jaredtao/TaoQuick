import QtQuick 2.9
import QtQuick.Controls 2.2
import "./Effects"
Rectangle  {
    anchors.fill: parent
    color: "black"
    TSoundByte {
        id: src
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -100
        interval: 240
    }

    ShaderEffectSource {
        id: mirror
        width: src.width
        height: src.height
        x: src.x
        y: src.y + src.height + 10
        opacity: 0.3
        sourceItem: src
        transform: Rotation {
            origin.x: mirror.width/2
            origin.y: mirror.height/2
            axis.x: 1; axis.y: 0; axis.z: 0
            angle: 180
        }
        //no effect
        //textureMirroring: ShaderEffectSource.MirrorHorizontally

    }
}
