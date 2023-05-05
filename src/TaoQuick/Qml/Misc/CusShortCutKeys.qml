import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQml 2.0
QtObject {
    id: shortCutKeys
    property bool shiftPressed: false
    property bool ctrlPressed: false
    signal selectAllPressed()
    signal selectAllReleased()
    signal escPressed()
    signal escReleased()
}
