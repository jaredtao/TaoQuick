import QtQuick 2.12
import QtQuick.Controls 2.12
Item {
    TextArea {
        text: qsTr(
"
<p>
   欢迎使用TaoQuick演示程序，此程序罗列了<br/>
TaoQuick的所有功能，并全面支持动态切换UI风格<br/>
(换皮肤)、动态翻译多国语言等功能。<br/>
</p>
<p>
    更多功能正在路上，敬请期待。
</p>
")
        font.pixelSize: 20
        textFormat: TextEdit.RichText
        anchors.centerIn: parent
        width: parent.width
        readOnly: true
    }
}
