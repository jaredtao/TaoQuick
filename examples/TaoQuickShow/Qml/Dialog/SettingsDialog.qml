import QtQuick 2.9
import QtQuick.Controls 2.2

import TaoQuick 1.0

Popup {
    id: root
    width: 600
    height: 340

    function show() {
        x = (parent.width - width) / 2
        y = (parent.height - height) / 2
        open()
    }
}
