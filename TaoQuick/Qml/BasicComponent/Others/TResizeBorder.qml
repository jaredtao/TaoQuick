import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    id: root
    //controller 要控制大小的目标，可以是Item，也可以是view，只要提供x、y、width、height等属性的修改
    //默认值为parent
    property var control: parent
    //左上角的拖拽
    TDragItem {
        id: leftTopHandle
        posType: posLeftTop
        onPosChange: {
            //不要简化这个判断条件，至少让以后维护的人能看懂。我当然知道能化简，化简过几分钟之后我自己都看不懂了。
            if (control.x + xOffset < control.x + control.width)
                control.x += xOffset;
            if (control.y + yOffset < control.y + control.height)
                control.y += yOffset;
            if (control.width - xOffset > 0)
                control.width-= xOffset;
            if (control.height -yOffset > 0)
                control.height -= yOffset;
        }
    }
    //右上角拖拽
    TDragItem {
        id: rightTopHandle
        posType: posRightTop
        x: parent.width - width
        onPosChange: {
            //向左拖动时，xOffset为负数
            if (control.width + xOffset > 0)
                control.width += xOffset;
            if (control.height - yOffset > 0)
                control.height -= yOffset;
            if (control.y + yOffset < control.y + control.height)
                control.y += yOffset;
        }
    }
    //左下角拖拽
    TDragItem {
        id: leftBottomHandle
        posType: posLeftBottom
        y: parent.height - height
        onPosChange: {
            if (control.x + xOffset < control.x + control.width)
                control.x += xOffset;
            if (control.width - xOffset > 0)
                control.width-= xOffset;
            if (control.height + yOffset > 0)
                control.height += yOffset;
        }
    }
    //右下角拖拽
    TDragItem {
        id: rightBottomHandle
        posType: posRightBottom
        x: parent.width - width
        y: parent.height - height
        onPosChange: {
            if (control.width + xOffset > 0)
                control.width += xOffset;
            if (control.height + yOffset > 0)
                control.height += yOffset;
        }
    }
    //上边拖拽
    TDragItem {
        posType: posTop
        width: parent.width - leftTopHandle.width - rightTopHandle.width
        x: leftBottomHandle.width
        onPosChange: {
            if (control.y + yOffset < control.y + control.height)
                control.y += yOffset;
            if (control.height - yOffset > 0)
                control.height -= yOffset;
        }
    }

    //左边拖拽
    TDragItem {
        posType: posLeft
        height: parent.height - leftTopHandle.height - leftBottomHandle.height
        y: leftTopHandle.height
        onPosChange: {
            if (control.x + xOffset < control.x + control.width)
                control.x += xOffset;
            if (control.width - xOffset > 0)
                control.width-= xOffset;
        }
    }
    //右边拖拽
    TDragItem {
        posType: posRight
        x: parent.width - width
        height: parent.height - rightTopHandle.height - rightBottomHandle.height
        y: rightTopHandle.height
        onPosChange: {
            if (control.width + xOffset > 0)
                control.width += xOffset;
        }
    }
    //下边拖拽
    TDragItem {
        posType: posBottom
        x: leftBottomHandle.width
        y: parent.height - height
        width: parent.width - leftBottomHandle.width - rightBottomHandle.width
        onPosChange: {
            if (control.height + yOffset > 0)
                control.height += yOffset;
        }
    }

}
