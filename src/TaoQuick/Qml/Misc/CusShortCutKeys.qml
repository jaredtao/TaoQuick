import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

QtObject {
    id: shortCutKeys
    property bool shiftPressed: false
    property bool ctrlPressed: false
    signal selectAllPressed()
    signal selectAllReleased()
    signal escPressed()
    signal escReleased()
}
