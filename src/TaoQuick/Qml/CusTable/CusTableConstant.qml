pragma Singleton

import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic


QtObject {
    readonly property int column0Width: 50
    readonly property int minWidth: 40
    readonly property int maxWidth: 400
    function bound(minValue, midValue, maxValue) {
        return Math.max(minValue, Math.min(midValue, maxValue))
    }
}
