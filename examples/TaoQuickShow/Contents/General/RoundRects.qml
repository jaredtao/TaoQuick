import QtQuick 2.9
import QtQml 2.0
import QtQuick.Controls 2.2
import TaoQuick 1.0

Item {
    anchors.fill: parent
    Rectangle { //背景红色，衬托一下
        x: 10
        width: 100
        height: 160
        color: "red"
    }

    RoundRectangle {
        id: roundRect
        x: 40
        y: 10
        width: 200
        height: 160
        radius: 40
        leftTopRound: lt.checked
        rightTopRound: rt.checked
        leftBottomRound: lb.checked
        rightBottomRound: rb.checked
        color: "#A0333666"      //
    }
    Rectangle { //背景红色，衬托一下
        x: 10
        y: 300
        width: 100
        height: 160
        color: "red"
        visible: hasShape
    }
    Item {
        id: roundRectShapeItem
        x: 40
        y: 340
        width: 200
        height: 160
    }
    Component.onCompleted: {
        if (hasShape) {
            var path = taoQuickImportPath + "TaoQuick/Qml/Basic/RoundRectangleShape.qml"
            console.log(path)
            var comp = Qt.createComponent(path)
            if (comp.status === Component.Ready) {
                var obj = comp.createObject(roundRectShapeItem)
                console.log("RoundRectangleShape ready")
                obj.radius = 40
                obj.width = 200
                obj.height = 160
                obj.leftTopRound = Qt.binding(function(){return lt.checked})
                obj.rightTopRound = Qt.binding(function(){return rt.checked})
                obj.leftBottomRound = Qt.binding(function(){return lb.checked})
                obj.rightBottomRound = Qt.binding(function(){return rb.checked})
                obj.color = "#A0333666"
                obj.visible = true
            } else {
                console.log("RoundRectangleShape error:", comp.errorString())
            }
        }
    }
    Grid {
        x: 300
        y: 10
        columns: 2
        spacing: 10

        CheckBox {
            id: lt
            text: "LeftTop"
            checked: true
        }
        CheckBox {
            id: rt
            text: "RightTop"
            checked: true
        }
        CheckBox {
            id: lb
            text: "LeftBottom"
            checked: true
        }
        CheckBox {
            id: rb
            text: "rightBottom"
            checked: true
        }
    }
}
