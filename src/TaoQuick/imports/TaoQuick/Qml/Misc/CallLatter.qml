import QtQuick 2.9

QtObject {
    Component {
        id: timerComp
        Timer {
            id: timer
            repeat: false
            property var _cb: function() {}
            onTriggered: {
                _cb()
                destroy(parent)
            }
            function setTimeout(callback, delayTime) {
                _cb = callback;
                interval = delayTime;
                start();
            }
        }
    }
    function callLatter(callback, delayTime) {
        if (Qt.callLater) {
            Qt.callLater(callback)
        } else {
            let timerObj = timerComp.createObject()
            timerObj.setTimeout(callback, delayTime)
        }
    }
    //    Component.onCompleted: {
    //        callLatter(function() {
    //            console.log("0")
    //        }, 0)
    //        callLatter(function() {
    //            console.log("100")
    //        }, 100)
    //        callLatter(function() {
    //            console.log("50")
    //        }, 50)
    //    }
}
