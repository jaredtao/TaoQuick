import QtQuick 2.9
import QtQuick.Controls 2.2

import TaoQuick 1.0
import "qrc:/TaoQuick"
Item {
    anchors.fill: parent
    TDialog {
        id: globalDialog
    }
    Row {
        spacing: 10
        anchors.centerIn: parent
        Button {
            text: "create file"
            onClicked: {
                globalDialog.createFile("create", ["All files (*.*)"], function(file){
                    console.log("create file", file)
                })
            }
        }
        Button {
            text: "open Image"
            onClicked: {
                globalDialog.openFile("Open one image", ["Image files (*.png *.jpg *.bmp)"], function(file){
                    console.log("Open one image", file)
                })
            }
        }
        Button {
            text: "open Image"
            onClicked: {
                globalDialog.openFiles("Open mulit images", ["Image files (*.png *.jpg *.bmp)"], function(files){
                    console.log("Open mulit images", files)
                })
            }
        }
        Button {
            text: "open folder"
            onClicked: {
                globalDialog.openFolder("Open one folder", function(file){
                    console.log("Open one folder", file)
                })
            }
        }
    }
}
