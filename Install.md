# 目录
- [目录](#%E7%9B%AE%E5%BD%95)
  - [代码结构](#%E4%BB%A3%E7%A0%81%E7%BB%93%E6%9E%84)
  - [TaoQuick 安装](#TaoQuick-%E5%AE%89%E8%A3%85)
    - [QtCreator安装TaoQuick](#QtCreator%E5%AE%89%E8%A3%85TaoQuick)
    - [命令行安装TaoQuick](#%E5%91%BD%E4%BB%A4%E8%A1%8C%E5%AE%89%E8%A3%85TaoQuick)
  - [TaoQuick dll的使用](#TaoQuick-dll%E7%9A%84%E4%BD%BF%E7%94%A8)
  - [TaoQuick Designer的使用](#TaoQuick-Designer%E7%9A%84%E4%BD%BF%E7%94%A8)

## 代码结构

![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/Struct.png)

TaoQuickDemo目录是Demo项目，示例如何使用TaoQuick库。

TaoQuick目录就是TaoQuick库。

可以使用生成的dll库，dll生成目录在项目的bin/TaoQuick目录下。

也可以将TaoQuick安装进Qt环境，支持在QtCreator中使用Designer进行拖拽式设计。

安装方法可以直接用QtCreator进行安装，也可以用命令行安装。

## TaoQuick 安装

### QtCreator安装TaoQuick

如下图所示:

![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/QtCreator-install.png)

任意编译器kit都可以，项目->构建步骤->添加build步骤->Make，添加之后在make参数中输入install。最后重新构建工程，即可完成安装。

TaoQuick库将被安装到{QTDIR}/qml/TaoQuick/ 路径下。

### 命令行安装TaoQuick

确保环境变量PATH中有QTDIR/bin，即能找到qmake

在TaoQuick目录，依次执行以下命令：

```
qmake
make
make install

```

## TaoQuick dll的使用

1. 将bin/TaoQuick文件夹复制到你的可执行程序同级目录下

2. 在你的Qml中写上这两句，就完成了TaoQuick的导入
```
import TaoQuick 1.0
import "qrc:/Tao/Qml/"
```

![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/TaoQuick-use.png)

`import TaoQuick 1.0` 是在导入dll库。
`import "qrc:/Tao/Qml/` 是在导入"qrc:/Tao/Qml/"路径下的qmldir文件。这个文件描述了TaoQuick中的所有组件。导入过后就能使用全部的组件了。

这种方式TaoQuick的Qml是以资源文件的方式编译进dll的，所以不支持QtCreator的语法高亮。（商业版有内建资源功能，或许可以支持）

## TaoQuick Designer的使用

1. 确保TaoQuick库被安装到{QTDIR}/qml/TaoQuick/目录下
2. 重启QtCreator，并在你的Qt项目的Designer 模式，Importer列表中，选择TaoQuick。选完记得按一下Ctrl + S保存一下，让Designer正确加载TaoQuick。

![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/Import.png)

3. 拖拽创建组件，修改属性
![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/Drag.gif)
