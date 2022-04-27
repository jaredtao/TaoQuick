import QtQuick 2.9
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
    }
    RoundRectangleShape{
        x: 40
        y: 340
        width: 200
        height: 160
        radius: 40
        leftTopRound: lt.checked
        rightTopRound: rt.checked
        leftBottomRound: lb.checked
        rightBottomRound: rb.checked
        color: "#A0333666"      //半透明色

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
