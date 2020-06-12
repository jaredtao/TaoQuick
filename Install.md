# 目录
- [目录](#%e7%9b%ae%e5%bd%95)
  - [代码结构](#%e4%bb%a3%e7%a0%81%e7%bb%93%e6%9e%84)
  - [TaoQuick 安装](#taoquick-%e5%ae%89%e8%a3%85)
    - [QtCreator安装TaoQuick](#qtcreator%e5%ae%89%e8%a3%85taoquick)
    - [命令行安装TaoQuick](#%e5%91%bd%e4%bb%a4%e8%a1%8c%e5%ae%89%e8%a3%85taoquick)
  - [TaoQuick dll的使用](#taoquick-dll%e7%9a%84%e4%bd%bf%e7%94%a8)
  - [TaoQuick Designer的使用](#taoquick-designer%e7%9a%84%e4%bd%bf%e7%94%a8)

## 代码结构

![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/CodeStruct/1.png)

src文件夹下包含四个子项目：

1. TaoQuick
   
   核心库，包括基础组件、动画效果的实现。 

   ![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/CodeStruct/2.png)
   
   核心库支持 make install 安装进QTDIR。

2. TaoQuickApp
   
   Demo项目，示例如何使用TaoQuick库。

   本质是一个内容加载器，提供基本的窗口和菜单栏等功能，并以插件的方式加载内容。

   ![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/CodeStruct/3.png)

3. TaoQuickPlugin

    插件，由TaoQuickApp加载。展示TaoQuick中的基础组件。

    ![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/CodeStruct/5.png)

4. TaoEffectPlugin

    插件，由TaoQuickApp加载。展示TaoQuick中的动画效果。

    ![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/CodeStruct/4.png)

## TaoQuick 安装

可以使用生成的dll库，dll生成目录在项目的bin/debug/TaoQuick 或者 bin/release/TaoQuick目录下。

也可以将TaoQuick安装进Qt环境，支持在QtCreator中使用Designer进行拖拽式设计。

安装方法可以用命令行安装， 可以直接用QtCreator进行安装。

### 命令行安装TaoQuick

确保环境变量PATH中有QTDIR/bin，即能找到qmake

在TaoQuick目录，依次执行以下命令：

```
qmake
make
make install

```

### QtCreator安装TaoQuick

如下图所示:

![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/QtCreator-install.png)

任意编译器kit都可以，项目->构建步骤->添加build步骤->Make，添加之后在make参数中输入install。最后重新构建工程，即可完成安装。

TaoQuick库将被安装到{QTDIR}/qml/TaoQuick/ 路径下。


## TaoQuick dll的使用

1. 将编译好的bin/debug/TaoQuick或者bin/release/TaoQuick文件夹，复制到你的可执行程序对应的debug或release的目录下

2. 在你的Qml中写上这两句，就完成了TaoQuick的导入
```
import TaoQuick 1.0
import "qrc:/Tao/Qml/"
```

![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/TaoQuick-use.png)

`import TaoQuick 1.0` 是在导入dll库。

`import "qrc:/Tao/Qml/` 是在导入"qrc:/Tao/Qml/"路径下的qmldir文件，这个文件描述了TaoQuick中的所有组件。

导入过后就能使用全部的组件了。

这种方式TaoQuick的Qml是以资源文件的方式编译进dll的，所以不支持QtCreator的语法高亮。（商业版有内建资源功能，或许可以支持）

## TaoQuick Designer的使用

1. 确保TaoQuick库被安装到{QTDIR}/qml/TaoQuick/目录下
2. 重启QtCreator，并在你的Qt项目的Designer 模式，Importer列表中，选择TaoQuick。选完记得按一下Ctrl + S保存一下，让Designer正确加载TaoQuick。

![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/Import.png)

3. 拖拽创建组件，修改属性
![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/Drag.gif)
