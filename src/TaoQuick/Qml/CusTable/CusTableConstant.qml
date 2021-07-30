pragma Singleton

import QtQuick 2.9

QtObject {
    readonly property int column0Width: 50
    readonly property int minWidth: 40
    readonly property int maxWidth: 400
    function bound(minValue, midValue, maxValue) {
        return Math.max(minValue, Math.min(midValue, maxValue))
    }
}
