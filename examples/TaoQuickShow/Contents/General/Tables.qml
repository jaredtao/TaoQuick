import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0

Item {
    anchors.fill: parent

    Item {
        id: mainItem
        width: 800
        height: 500
        anchors {
            centerIn: parent
            verticalCenterOffset: -160
        }
        Row {
            spacing: 10
            CusLabel {
                text: qsTr("selectCount: %1").arg(deviceAddModel.selectedCount) + trans.transString
            }
            CusLabel {
                text: qsTr("checkedCount: %1").arg(deviceAddModel.checkedCount) + trans.transString
            }
            CusLabel {
                text: qsTr("visibledCount: %1").arg(deviceAddModel.visibledCount) + trans.transString
            }
        }
        CusTextField_Search {
            anchors {
                right: parent.right
                rightMargin: 10
                top: parent.top
            }
            onTextChanged: {
                deviceAddModel.search(text)
            }
            placeholderText: qsTr("Search") + trans.transString
        }
        Rectangle {
            border.color: CusConfig.controlBorderColor
            color: CusConfig.backgroundColor
            anchors {
                left: cusHeader.left
                leftMargin: -1
                right: cusHeader.right
                rightMargin: -1
                top: cusHeader.top
                topMargin: -1
                bottom: cusView.bottom
                bottomMargin: -1
            }
        }
        CusTableHeader {
            id: cusHeader
            y: 50
            width: parent.width
            height: 30
            dataObj: deviceAddModel
            headerNames: deviceAddModel.headerRoles
            headerRoles: deviceAddModel.headerRoles
            widthList: cusView.widthList
            xList: cusView.xList
            property real avalidWidth
            updateWidthList: function() {
                avalidWidth = width - CusTableConstant.column0Width
                widthList = [CusTableConstant.column0Width, avalidWidth * 0.33,avalidWidth * 0.33,avalidWidth * 0.33]
            }
        }

        //12 items in one page
        property int itemCountPerPage:12
        property int currentPage:1

        //Pages round down
        property int page:cusView.count/itemCountPerPage

        //Actual number of pages (exactly divide pageCount = page, otherwise pageCount is 1 page more than page)
        property int pageCount: page*itemCountPerPage<cusView.count?page+1:page

        //--listView Page turning function
        function changePage(next){
            var currentViewIndex = cusView.indexAt(cusView.contentX,cusView.contentY)
            if(currentViewIndex%itemCountPerPage!==0)
            {   //the last page
                if(!next){//Page forward
                    cusView.positionViewAtIndex((page-1)*itemCountPerPage,ListView.Beginning)
                }
            }
            else
            {
                var i = 0
                for(; i<pageCount;i++){
                    if(i*itemCountPerPage<=currentViewIndex&&currentViewIndex<(i+1)*itemCountPerPage){
                        //Find which page the current ViewIndex belongs to
                        break
                    }
                }

                console.log("currentViewIndex ",currentViewIndex)

                //Page forward and backward
                currentViewIndex =(next?(i+1):(i-1))*itemCountPerPage

                //Ranges
                currentViewIndex = currentViewIndex<0?0:currentViewIndex
                currentViewIndex = currentViewIndex>=cusView.count - 1?cusView.count - 1:currentViewIndex

                console.log("nextViewIndex ",currentViewIndex)

                cusView.positionViewAtIndex(currentViewIndex,ListView.Beginning)

            }
        }

        //--Calculate page number
        function showPage(){
            var currentViewIndex = cusView.indexAt(cusView.contentX,cusView.contentY)
            if(currentViewIndex%itemCountPerPage!==0){
                //the last page
                console.log("final")
                currentPage = pageCount
            }else{
                for(var i = 0; i<pageCount;i++){
                    if(i*itemCountPerPage<=currentViewIndex&&currentViewIndex<(i+1)*itemCountPerPage){
                        //Find which page the current ViewIndex belongs to
                        currentPage = i + 1
                        break
                    }
                }
            }
            console.log("currentPage",currentPage)
            console.log("page",page)
            console.log("pageCount",pageCount)

        }

        signal lastpage()
        onLastpage:{
            changePage(false)
            showPage()
        }
        signal nextpage()
        onNextpage:{
            changePage(true)
            showPage()
        }

        CusTableView {
            id: cusView
            y: cusHeader.y + cusHeader.height
            width: parent.width
            height: parent.height - y - 40
            model: deviceAddModel
            onPressed: {
                doPress(mouseX, mouseY)
            }
            onRightPressed: {
                var index = indexAt(mouseX, mouseY + contentY)
                if (index < 0 || index >= count) {
                    return
                }
                tableMenu.popup(mouseX, mouseY)
            }
            onReleased: {

                doRelease()
            }
            onPositionChanged: {
                doPositionChanged(mouseX, mouseY)
            }
            onDoubleClicked: {
                var index = indexAt(mouseX, mouseY + contentY)
                if (index < 0 || index >= count) {
                    return
                }
                if (cusHeader.xList[1] <= mouseX
                        && mouseX <= cusHeader.xList[2]) {

                    editInput.x = cusHeader.xList[1]
                    editInput.y = cusView.y + (parseInt(mouseY / CusConfig.fixedHeight)) * CusConfig.fixedHeight
                    editInput.width = cusHeader.widthList[1]
                    editInput.height = CusConfig.fixedHeight
                    editInput.index = index
                    var dataObj = deviceAddModel.data(index)
                    editInput.text = dataObj[deviceAddModel.headerRoles[0]]
                    editInput.visible = true
                    editInput.focus = true
                }
            }
            Menu {
                id: tableMenu
                MenuItem {
                    text: qsTr("Edit row")
                    onTriggered: {
                        var mouseX = tableMenu.x
                        var mouseY = tableMenu.y
                        var index = cusView.indexAt(mouseX, mouseY + cusView.contentY)
                        if (index < 0 || index >= cusView.count) {
                            return
                        }
                        if (cusHeader.xList[1] <= mouseX && mouseX <= cusHeader.xList[2]) {
                            editInput.x = cusHeader.xList[1]
                            editInput.y = cusView.y + (parseInt(mouseY / CusConfig.fixedHeight)) * CusConfig.fixedHeight
                            editInput.width = cusHeader.widthList[1]
                            editInput.height = CusConfig.fixedHeight
                            editInput.index = index
                            var dataObj = deviceAddModel.data(index)
                            editInput.text = dataObj[deviceAddModel.headerRoles[0]]
                            editInput.visible = true
                            editInput.focus = true
                        }
                    }
                }
                MenuItem {
                    text: qsTr("Insert before row")
                    onTriggered: {
                        var mouseX = tableMenu.x
                        var mouseY = tableMenu.y
                        var index = cusView.indexAt(mouseX, mouseY + cusView.contentY)
                        if (index < 0 || index >= cusView.count) {
                            return
                        }
                        deviceAddModel.insertBeforeRow(index)
                    }
                }
                MenuItem {
                    text: qsTr("Remov row")
                    onTriggered: {
                        var mouseX = tableMenu.x
                        var mouseY = tableMenu.y
                        var index = cusView.indexAt(mouseX, mouseY + cusView.contentY)
                        if (index < 0 || index >= cusView.count) {
                            return
                        }
                        deviceAddModel.removeRow(index)
                    }
                }
            }
            delegate: CusTableRow {
                width: cusView.width
                roles: cusView.model.headerRoles
                dataObj: model.display
                widthList: cusHeader.widthList
                xList: cusHeader.xList
                onCheckedChanged: {
                    deviceAddModel.check(index, checked)
                }
            }
        }

        Column {
            x: cusHeader.splitingIndex > 0 ? (cusHeader.x + cusHeader.xList[cusHeader.splitingIndex + 1]) : 0
            y: cusView.y
            height: cusView.height
            width: 1
            spacing: 2
            visible: cusHeader.splitingIndex > 0 && !cusHeader.isOut
            Repeater {
                model: parent.height / 6
                enabled: parent.visible
                Rectangle {
                    width: 1
                    height: 4
                    color: CusConfig.themeColor
                }
            }
        }
        Column {
            anchors {
                left: cusView.left
                top: cusView.bottom
                topMargin: 4
            }
            spacing: 10
            Row {
                height: CusConfig.fixedHeight
                spacing: 10
                CusButton_Blue {
                    width: 120
                    text: qsTr("Generate data") + trans.transString
                    onClicked: {
                        deviceAddModel.initData()
                    }
                }

                CusButton_Blue {
                    width: 120
                    text: qsTr("Append one") + trans.transString
                    onClicked:  {
                        deviceAddModel.addOne()
                    }
                }
                CusTextField {
                    id: countInput
                    width: 120
                    validator: IntValidator {bottom: 0 ;top: 100 * 10000}
                    placeholderText: qsTr("Number to add") + trans.transString
                }
                CusButton_Blue {
                    width: 120
                    text: qsTr("Append") + trans.transString
                    onClicked:  {
                        deviceAddModel.addMulti(parseInt(countInput.text))
                    }
                }
                CusButton_Blue {
                    width: 160
                    text: qsTr("Insert before selected") + trans.transString
                    onClicked: {
                        deviceAddModel.insertBeforeSelected()
                    }
                }

            }
            Row {
                height: CusConfig.fixedHeight
                spacing: 10
                CusButton_Blue {
                    width: 120
                    text: qsTr("Clear All") + trans.transString
                    onClicked:  {
                        deviceAddModel.clearAll()
                    }
                }
                CusButton_Blue {
                    width: 120
                    text: qsTr("Remove Selected") + trans.transString
                    onClicked:  {
                        deviceAddModel.removeSelected()
                    }
                }
                CusButton_Blue {
                    width: 120
                    text: qsTr("Remove Checked") + trans.transString
                    onClicked:  {
                        deviceAddModel.removeChecked()
                    }
                }
            }
            Row {
                height: CusConfig.fixedHeight
                spacing: 10
                CusButton_Blue {
                    width: 120
                    text: qsTr("Select All") + trans.transString
                    onClicked:  {
                        deviceAddModel.selectAll()
                    }
                }
                CusButton_Blue {
                    width: 120
                    text: qsTr("Deselect All") + trans.transString
                    onClicked:  {
                        deviceAddModel.deselectAll()
                    }
                }

                CusButton_Blue {
                    width: 120
                    text: qsTr("Undo") + trans.transString
                    onClicked:  {
                        deviceAddModel.deselectAll()
                    }
                }
                CusButton_Blue {
                    width: 120
                    text: qsTr("Redo") + trans.transString
                    onClicked:  {
                        deviceAddModel.deselectAll()
                    }
                }
                CusButton_Blue {
                    width: 120
                    text: qsTr("Last Page") + trans.transString
                    onClicked:  {
                        mainItem.lastpage()
//                        changePage(false)
//                        showPage()
                    }
                }
                CusButton_Blue {
                    width: 120
                    text: qsTr("Next Page") + trans.transString
                    onClicked:  {
                        mainItem.nextpage()
//                        changePage(true)
//                        showPage()
                    }
                }


            }
        }
        CusTextField {
            id: editInput
            visible: false
            onEditingFinished: {
                deviceAddModel.doUpdateName(index, text)
                visible = false
            }
            property int index: -1
            onFocusChanged: {
                if (!focus) {
                    deviceAddModel.doUpdateName(index, text)
                    visible = false
                }
            }
        }
        Column {
            x: cusHeader.x + cusHeader.mouseX
            y: cusView.y
            visible: cusHeader.splitingIndex >= 1
            height: cusView.height
            width: 1
            spacing: 2
            Repeater {
                model: (cusHeader.isSpliting
                        && !cusHeader.isOut) ? parent.height / 6 : 0
                Rectangle {
                    width: 1
                    height: 4
                    color: CusConfig.splitLineColor
                }
            }
        }
    }
    Column {
        anchors {
            left: mainItem.left
            top: mainItem.bottom
            topMargin: 120
        }
        CusLabel {
            text: qsTr("Table has these features:") + trans.transString
        }
        CusLabel {
            text: qsTr("    * Select row by 'mouse click', 'Ctrl + click' for Multi-select, 'Shift + click' for Continue-select") + trans.transString
        }
        CusLabel {
            text: qsTr("    * Draw rect select, mouse press and move can draw a rect, then these rows above rect will be selected") + trans.transString
        }
        CusLabel {
            text: qsTr("    * Ctrl + A for select all, Esc for deselect all") + trans.transString
        }
        CusLabel {
            text: qsTr("    * Check row by CheckBox in Column 0; Check/unchecked multi rows flow selected rows") + trans.transString
        }
        CusLabel {
            text: qsTr("    * Check All rows by header of Column 0") + trans.transString
        }
        CusLabel {
            text: qsTr("    * Edit Column 1 by double click, and update data to model after edit") + trans.transString
        }
        CusLabel {
            text: qsTr("    * Fuzzy search") + trans.transString
        }
        CusLabel {
            text: qsTr("    * Reset column width by drag header splite line") + trans.transString
        }
        CusLabel {
            text: qsTr("    * Sort by click header, click again can switch ascending or descending") + trans.transString
        }
    }
}
