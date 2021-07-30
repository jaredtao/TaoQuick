import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."

Item {
    id: cusPageIndicator
    implicitHeight: CusConfig.fixedHeight
    width: childrenRect.width
    //every indicator width
    property int indicatorWidth: 46

    property int spacing: 10

    property int currentIndex: 0

    property int count: 0

    //middle display count
    property int middleDisplayCount: 5
    //middle start
    property int middleStartIndex: 1
    //middle step
    property int middleStep: 5

    Row {
        height: parent.height
        spacing: cusPageIndicator.spacing
        CusLabel {
            height: parent.height
            text: qsTr(count > 1 ? "Total %1 items" : "Total %1 item").arg(count) +  + CusConfig.transString
        }
        //left button for last current
        CusButton_ImageColorOverlay {
            id: leftBtn
            btnImgNormal: CusConfig.imagePathPrefix + "/left.png"
            width: indicatorWidth
            height: parent.height
            onClicked: {
                if (currentIndex - 1 >= 0) {
                    gotoIndex(currentIndex - 1)
                }
            }
            backgroundColor: hovered ? CusConfig.controlColor_hovered : (pressed ? CusConfig.controlColor_pressed : CusConfig.controlColor)
            colorNormal: CusConfig.textColor
            colorHovered: CusConfig.textColor_hovered
            colorPressed: CusConfig.textColor_hovered
            colorDisable: CusConfig.textColor_disabled
            enabled: currentIndex > 0
        }
        //start button for first
        CusTextButton {
            id: startBtn
            width: indicatorWidth
            height: parent.height
            text: "1"
            //at last 1 item for begin
            visible: count > 0
            selected: currentIndex === 0
            onClicked: {
                gotoIndex(0)
            }
        }
        //last button for last 5, if need ellipsis
        CusButton_ImageColorOverlay {
            id: lastBtn
            btnImgNormal: CusConfig.imagePathPrefix + ((hovered
                                                        || pressed) ? "/last.png" : "/ellipsis.png")
            width: indicatorWidth
            height: parent.height
            visible: startBtn.visible && middleStartIndex > 1
            tipText: qsTr(middleStep > 1 ? "last %1 items" : "last %1 item").arg(middleStep) +  + CusConfig.transString
            onClicked: {
                gotoLast()
            }
        }
        // middle
        Repeater {
            id: generater
            enabled: cusPageIndicator.count - 2 > 0
            model: Math.min(middleDisplayCount, cusPageIndicator.count - 2)
            delegate: CusTextButton {
                implicitWidth: indicatorWidth
                implicitHeight: cusPageIndicator.height
                text: middleStartIndex + index + 1
                selected: currentIndex === middleStartIndex + index
                onClicked: {
                    gotoIndex(middleStartIndex + index)
                }
            }
        }
        //next button for next 5, if need ellipsis
        CusButton_ImageColorOverlay {
            id: nextBtn
            btnImgNormal: CusConfig.imagePathPrefix + ((hovered
                                                        || pressed) ? "/next.png" : "/ellipsis.png")
            width: indicatorWidth
            height: parent.height
            visible: count > 2
                     && ((count - 1) - (middleStartIndex + generater.count) >= 1)
            tipText: qsTr(
                         middleStep > 1 ? "next %1 items" : "next %1 item").arg(
                         middleStep) + CusConfig.transString
            onClicked: {
                gotoNext()
            }
        }
        //end button for end one
        CusTextButton {
            id: endBtn
            width: indicatorWidth
            height: parent.height
            text: count
            //at last 2 item, one for begin, one for end
            visible: count > 1
            selected: currentIndex === count - 1
            onClicked: {
                gotoIndex(count - 1)
            }
        }
        //next one for next current
        CusButton_ImageColorOverlay {
            id: rightBtn
            btnImgNormal: CusConfig.imagePathPrefix + "/right.png"
            width: indicatorWidth
            height: parent.height
            onClicked: {
                if (currentIndex + 1 < count) {
                    gotoIndex(currentIndex + 1)
                }
            }
            backgroundColor: hovered ? CusConfig.controlColor_hovered : (pressed ? CusConfig.controlColor_pressed : CusConfig.controlColor)
            colorNormal: CusConfig.textColor
            colorHovered: CusConfig.textColor_hovered
            colorPressed: CusConfig.textColor_hovered
            colorDisable: CusConfig.textColor_disabled
            enabled: currentIndex < count - 1
        }
    }
    function gotoLast() {
        var t = currentIndex - middleStep
        if (t < 0) {
            t = 0
        }
        gotoIndex(t)
    }
    function gotoNext() {
        var t = middleStartIndex + middleStep
        if (t > count - 1) {
            t = count - 1
        }
        gotoIndex(t)
    }
    function gotoIndex(targetIndex) {
        if (targetIndex < 0 || targetIndex >= count) {
            return
        }
        if (targetIndex === currentIndex) {
            return
        }
        currentIndex = targetIndex
    }
    onCurrentIndexChanged: {
        updateMiddle()
    }
    Component.onCompleted: {
        updateMiddle()
    }
    function updateMiddle() {
        if (count - 2 <= middleDisplayCount) {
            middleStartIndex = 1
        } else {
            var minV = 1
            var maxV = count - middleDisplayCount - 1
            var half = parseInt(generater.count / 2)
            var midV = currentIndex - half
            middleStartIndex = bound(minV, midV, maxV)
        }
    }
    function bound(minValue, midValue, maxValue) {
        return Math.max(minValue, Math.min(midValue, maxValue))
    }
}
