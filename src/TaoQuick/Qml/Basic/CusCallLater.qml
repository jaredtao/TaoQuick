import QtQuick 2.12
import QtQuick.Controls 2.12
Item {
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
    function callLate(callback, delayTime) {
        var timerObj = timerComp.createObject()
        timerObj.setTimeout(callback, delayTime)
    }

}
