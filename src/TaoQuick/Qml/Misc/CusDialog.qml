import QtQml
import QtQuick
import QtQuick.Controls
import Qt.labs.platform 1.1
Item {
    //顶层使用Item，不用FileDialog，屏蔽FileDialog内部属性和函数
    property var __acceptCallback: function (file) {}

    FileDialog {
        id: d
        onAccepted: {
            switch (fileMode) {
            case FileDialog.SaveFile:
                __acceptCallback(d.currentFile)
                break
            case FileDialog.OpenFile:
                __acceptCallback(d.currentFile)
                break
            case FileDialog.OpenFiles:
                __acceptCallback(d.currentFiles)
                break
            default: break
            }
        }
    }
    FolderDialog {
        id: f
        onAccepted: {
            __acceptCallback(d.currentFolder)
        }
    }
    function createFile(title, nameFilters, callback) {
        d.fileMode = FileDialog.SaveFile
        d.title = title
        d.nameFilters = nameFilters
        __acceptCallback = callback
        d.open()
    }
    function openFile(title, nameFilters, callback) {
        d.fileMode = FileDialog.OpenFile
        d.title = title
        d.nameFilters = nameFilters
        __acceptCallback = callback
        d.open()
    }
    function openFiles(title, nameFilters, callback) {
        d.fileMode = FileDialog.OpenFiles
        d.title = title
        d.nameFilters = nameFilters
        __acceptCallback = callback
        d.open()
    }
    function openFolder(title, callback) {
        f.title = title
        __acceptCallback = callback
        f.open()
    }
}
