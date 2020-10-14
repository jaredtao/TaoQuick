# catalogue
- [catalogue](#catalogue)
  - [Code Struct](#code-struct)
  - [TaoQuick Build](#taoquick-build)
  - [TaoQuick Install](#taoquick-install)
  - [TaoQuick Use](#taoquick-use)
  - [TaoQuick Designer-mode](#taoquick-designer-mode)

## Code Struct


1. 'src' folder contains core library TaoQuick

   core library contains basic component, animation effect ans so and.

   main code is qml, cpp only warp qmls to resource plugin. (support Qt5.12 and Qt5.15)

   support use ' make install ' install  into QTDIR

   support Drag & Drop in QtDesigner.

2. 'exmaples' folder contains demo
   
   TaoQuickShow，show how to use TaoQuick。

    It's a content loader, provide  basic window and menu, dynamic load content .

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

or you can install TaoQuick to QTDIR.

2. import in you qml
```
import TaoQuick 1.0

```

![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/TaoQuick-use.png)

`import TaoQuick 1.0` is import library.
`import "qrc:/TaoQuick/` is import Resource by qmldir file in "qrc:/TaoQuick/"

this use method not support QtCreator HighLight.

## TaoQuick Designer-mode

TaoQuick support  Designer-mode in QtCreator.

1. make sure TaoQuick is installed to {QTDIR}/qml/TaoQuick/
2. Restart QtCreator，open you project and change to Designer-mode，in Importer ComboBox，select TaoQuick, 
   
   press Ctrl + S to save, then QtCreator will load TaoQuick.

![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/Import.png)


Now, you can create component by drag , change propery easily.

![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/Drag.gif)
