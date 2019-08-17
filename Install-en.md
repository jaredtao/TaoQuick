# catalogue
- [catalogue](#catalogue)
  - [Code Struct](#code-struct)
  - [TaoQuick Build](#taoquick-build)
  - [TaoQuick Install](#taoquick-install)
  - [TaoQuick Use](#taoquick-use)
  - [TaoQuick Designer-mode](#taoquick-designer-mode)

## Code Struct

![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/CodeStruct/1.png)

'src' folder contains 4 sub-project：

1. TaoQuick
   
   main library.

   ![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/CodeStruct/2.png)
   
   support use ' make install ' install  into QTDIR。

2. TaoQuickApp
   
   Demo，show how use TaoQuick。

    It's a content loader, provide  basic window and menu, load content by plugin.

   ![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/CodeStruct/3.png)

3. TaoQuickPlugin

    one plugin, show Basic Component in TaoQuick.

    ![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/CodeStruct/5.png)

4. TaoEffectPlugin

    one plugin, show Effect Component in TaoQuick.

    ![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/CodeStruct/4.png)

## TaoQuick Build

Commond line, just use 
`
qmake
make
`
after build, library will be auto copied in  "bin/debug/TaoQuick" or "bin/release/TaoQuick"

## TaoQuick Install
also you can use 

`
make install

`
library will be installed in "{QTDIR}/qml/TaoQuick"

QtCreator also can use build argument.

![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/QtCreator-install.png)


## TaoQuick Use

1. copy "bin/debug/TaoQuick" or "bin/release/TaoQuick" to you binary folder

2. import in you qml
```
import TaoQuick 1.0
import "qrc:/Tao/Qml/"
```

![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/TaoQuick-use.png)

`import TaoQuick 1.0` is import library.
`import "qrc:/Tao/Qml/` is import Resource by qmldir file in "qrc:/Tao/Qml/"

this use method not support QtCreator HighLight.

## TaoQuick Designer-mode

TaoQuick support  Designer-mode in QtCreator.

1. make sure TaoQuick is installed to {QTDIR}/qml/TaoQuick/
2. Restart QtCreator，open you project and change to Designer-mode，in Importer ComboBox，select TaoQuick, 
   
   press Ctrl + S to save, then QtCreator will load TaoQuick.

![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/Import.png)


Now, you can create component by drag , change propery easily.

![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/Drag.gif)
