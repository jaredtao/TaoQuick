import QtQuick 2.9
import QtQuick.Dialogs 1.3

Item {
    //顶层使用Item，不用FileDialog，屏蔽FileDialog内部属性和函数
    readonly property int typeCreateFile: 0
    readonly property int typeOpenFile: 1
    readonly property int typeOpenFiles: 2
    readonly property int typeOpenFolder: 3
    property int __type
    property var __acceptCallback: function (file) {}

    FileDialog {
        id: d
        folder: shortcuts.home
        onAccepted: {
            switch (__type) {
            case typeCreateFile:
                __acceptCallback(d.fileUrl)
                break
            case typeOpenFile:
                __acceptCallback(d.fileUrl)
                break
            case typeOpenFiles:
                __acceptCallback(d.fileUrls)
                break
            case typeOpenFolder:
                __acceptCallback(d.folder)
                break
            }
        }
    }
    function createFile(title, nameFilters, callback) {
        __type = typeCreateFile
        d.selectExisting = false
        d.selectFolder = false
        d.selectMultiple = false
        d.title = title
        d.nameFilters = nameFilters
        __acceptCallback = callback
        d.open()
    }
    function openFile(title, nameFilters, callback) {
        __type = typeOpenFile
        d.selectExisting = true
        d.selectFolder = false
        d.selectMultiple = false
        d.title = title
        d.nameFilters = nameFilters
        __acceptCallback = callback
        d.open()
    }
    function openFiles(title, nameFilters, callback) {
        __type = typeOpenFiles
        d.selectExisting = true
        d.selectFolder = false
        d.selectMultiple = true
        d.title = title
        d.nameFilters = nameFilters
        __acceptCallback = callback
        d.open()
    }
    function openFolder(title, callback) {
        __type = typeOpenFolder
        d.selectExisting = true
        d.selectFolder = true
        d.selectMultiple = false
        d.title = title
        __acceptCallback = callback
        d.open()
    }
}
