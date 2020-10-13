pragma Singleton

import QtQuick 2.9

QtObject {
    id: config
    objectName: "config"
    property bool isWhiteTheme: true
    property string imagePathPrefix

    Component.onCompleted: {
        if (typeof (imgPath) != "undefined" && imgPath !== null
            && imgPath.length > 0) {
            imagePathPrefix = imgPath
        }
    }
    property int fixedHeight: 30
    property int maximumLength: 64
    property int fontSize_default: 14
    property int fontSize_h0: 24
    property int fontSize_h1: 18
    property int fontSize_h2: 16
    property int fontSize_h3: 14
    property int fontSize_h4: 14
    property int fontSize_h5: 13
    property int fontSize_tableContent: 12

    property color textColor: "#363636"
    property color blueTextColor: "#579ee5"
    property color borderColor: "#6CB2E8"
    property color h5TextColor: "#515151"

    property color backgroundColor0: "#f9f9f9"
    property color backgroundColor1: "#d7d9dc"
    property color backgroundColor2: "#f9f9f9"
    property color backgroundColor3: "#f9f9f9"

    property color backgroundBorderColor: "#797979"

    property color invalidColor: "#ff0000"
    property color controlBackgroundColor: "#ffffff"
    property color controlBackgroundColor_disabled: "#f0f0f0"
    property color controlBackgroundColor_highlight: "#1f8efa"
    property color controlBackgroundColor_hovered: Qt.lighter("#1f8efa", 1.4)

    property int controlBorderRadius: 4
    property color controlBorderColor: "#a0a0a0"
    property color controlBorderColor_hovered: "#579ee5"

    property color controlTextColor_highlight: "#ffffff"
    property color controlTextColor_disable: "#7d7d7b"

    property color scheduleRectColor: "#fff5f5"
    property color scheduleRectBorderColor: "#c9fef8"

    property color tableRowColor: "#f9f9f9"
    property color tableRowAlterColor: "#eeeeee"
    property color tableRowSelectColor: "#e1ecf6"
    property color tableRowAlterSelectColor: "#d8e3ed"
    property color tableBorderColor: "#bfbfbf"
    property color tableStechColor: "#579ee5"
    property color tableHeaderBackgroundColor: "#579ee5"
    property color tableHeaderBorderColor: "#CFD1D0"
    property color tableSelectRectColor: "#aaccee"

    property color scrollBarBackgroundColor: "#d4d4d4"
    property int scrollBarRadius: 2
    property int scrollBarMinLen: 40
    property int scrollBarSize: 10
    property int scrollBarSize_Smaller: 5

    property color tipBackgroundColor: "#ffffff"
    property color tipBorderColor: "#8b8b8b"
    property color tipTextColor: "#393939"
    property int tipTextPixel: 12

    function changeByObject(themeObj) {
        textColor = themeObj.textColor
        blueTextColor = themeObj.blueTextColor
        borderColor = themeObj.borderColor
        h5TextColor = themeObj.h5TextColor

        backgroundColor0 = themeObj.backgroundColor0
        backgroundColor1 = themeObj.backgroundColor1
        backgroundColor2 = themeObj.backgroundColor2
        backgroundColor3 = themeObj.backgroundColor3

        backgroundBorderColor = themeObj.backgroundBorderColor

        controlBackgroundColor = themeObj.controlBackgroundColor
        controlBackgroundColor_disabled = themeObj.controlBackgroundColor_disabled
        controlBackgroundColor_highlight = themeObj.controlBackgroundColor_highlight
        controlBackgroundColor_hovered: Qt.lighter(
                                            controlBackgroundColor_highlight,
                                            1.4)

        controlBorderColor = themeObj.controlBorderColor
        controlBorderColor_hovered = themeObj.controlBorderColor_hovered

        controlTextColor_highlight = themeObj.controlTextColor_highlight
        controlTextColor_disable = themeObj.controlTextColor_disable

        scheduleRectColor = themeObj.scheduleRectColor
        scheduleRectBorderColor = themeObj.scheduleRectBorderColor

        tableRowColor = themeObj.tableRowColor
        tableRowAlterColor = themeObj.tableRowAlterColor
        tableRowSelectColor = themeObj.tableRowSelectColor
        tableRowAlterSelectColor = themeObj.tableRowAlterSelectColor
        tableBorderColor = themeObj.tableBorderColor
        tableStechColor = themeObj.tableStechColor
        tableHeaderBackgroundColor = themeObj.tableHeaderBackgroundColor
        tableHeaderBorderColor = themeObj.tableHeaderBorderColor

        scrollBarBackgroundColor = themeObj.scrollBarBackgroundColor

        isWhiteTheme = false
    }
    property QtObject blackTheme: QtObject {
        id: blackTheme
        property color textColor: "#e3e3e3"
        property color blueTextColor: "#579ee5"
        property color borderColor: "#6CB2E8"
        property color h5TextColor: "#515151"

        property color backgroundColor0: "#2b2d30"
        property color backgroundColor1: "#2b2d30"
        property color backgroundColor2: "#2b2d30"
        property color backgroundColor3: "#2b2d30"

        property color backgroundBorderColor: "#1e1f22"

        property color controlBackgroundColor: "#1e1f22"
        property color controlBackgroundColor_disabled: "#2b2d30"
        property color controlBackgroundColor_highlight: "#579ee5"
        property color controlBackgroundColor_hovered: Qt.lighter("#1f8efa",
                                                                  1.4)

        property color controlBorderColor: "#42454a"
        property color controlBorderColor_hovered: "#579ee5"

        property color controlTextColor_highlight: "#ffffff"
        property color controlTextColor_disable: "#7d7d7b"

        property color scheduleRectColor: "#fff5f5"
        property color scheduleRectBorderColor: "#c9fef8"

        property color tableRowColor: "#24272a"
        property color tableRowAlterColor: "#2d3034"
        property color tableRowSelectColor: "#1c1d1d"
        property color tableRowAlterSelectColor: "#1c1d1d"
        property color tableBorderColor: "#121313"
        property color tableStechColor: "#579ee5"
        property color tableHeaderBackgroundColor: "#383b40"
        property color tableHeaderBorderColor: "#202224"

        property color scrollBarBackgroundColor: "#808080"
    }
}
