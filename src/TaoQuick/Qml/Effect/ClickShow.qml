import QtQuick 2.9
import QtQuick.Controls 2.2

Item {
    id: clickShow
    Connections {
        target: view
        ignoreUnknownSignals: true
        //Qt5.15 and after
        function onMousePressed(xPos, yPos, button) {
            clickShow.brust(xPos, yPos, button)
        }
        //5.12 and before
        onMousePressed: {
            clickShow.brust(xPos, yPos, button)
        }
    }
    Component {
        id: brushComp
        Item {
            id: circleItem
            property color circleColor
            Rectangle {
                id: circle
                anchors.centerIn: parent
                color: "transparent"
                width: radius * 2
                height: radius * 2
                opacity: 0
                visible: opacity > 0
                border.color: circleItem.circleColor
                border.width: 4
            }
            SequentialAnimation {
                id: animation
                running: true
                loops: 1
                ParallelAnimation {
                    NumberAnimation {
                        target: circle
                        property: "radius"
                        from: 1
                        to: 60
                        duration: 400
                    }
                    NumberAnimation {
                        target: circle
                        property: "opacity"
                        from: 1
                        to: 0
                        duration: 400
                    }
                }
                ScriptAction {
                    script: {
                        destroy(circleItem)
                    }
                }
            }
        }
    }

    function getButtonColor(button)
    {
        var c = "dodgerblue";
        switch (button)
        {
        case Qt.LeftButton:
            break;
        case Qt.MiddleButton:
            c = "green";
            break;
        case Qt.RightButton:
            c = "orangered";
            break;
        case Qt.XButton1:
            c = "grey";
            break;
        case Qt.XButton2:
            c = "blueviolet";
            break;
        default:
            break;
        }
        return c;
    }
    function brust(xPos, yPos, button)
    {
        brushComp.createObject(clickShow, {x: xPos, y: yPos, circleColor: getButtonColor(button)})
    }
}
