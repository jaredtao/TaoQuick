# TaoQuick Library

![TaoQuick logo](https://github.com/jaredtao/TaoQuick/raw/master/examples/TaoQuickShow/Image/logo/milk.png) 

TaoQuick Library

## Headings

TaoQuick is a QtQuick/Qml Component library, integrated some commonly used QtQuick components, and

make the appropriate function expansion to facilitate development of Qml applications.

## Preview

Main Page

![Main Page](https://github.com/jaredtao/TaoQuick/raw/master/preview/main-en.png)

Change Skin

![Change Skin](https://github.com/jaredtao/TaoQuick/raw/master/preview/skin-en.png)

I18n
![I18n](https://github.com/jaredtao/TaoQuick/raw/master/preview/I18n-en.png)

Button Controls
![Button Controls](https://github.com/jaredtao/TaoQuick/raw/master/preview/Buttons-en.png)

Data Entry Controls
![Data Entry Controls](https://github.com/jaredtao/TaoQuick/raw/master/preview/Data-en.png)

TableControls
![TableControls](https://github.com/jaredtao/TaoQuick/raw/master/preview/Table-en.png)

## TaoQuick Core Library

Core Library source code path:

src/TaoQuick/imports/TaoQuick/Qml

![](https://github.com/jaredtao/TaoQuick/raw/master/doc/core.png)

To avoid confusion with Qt default components, TaoQuick components names all begin with Cus (The abbreviation of Custom)

CusConfig is global configuration, mainly contain font、 theme and so on, all components are displayed in this configuration

Other Contents reference to above table：


|Content|Reference|Remark|
|----|----|----|
|Basic|Basic Controls| such as Text, ToolTip, It is used to unify the basic components in the whole project and facilitate the global replacement when the project becomes huge|
|CusBackground|A simple background box|it is usually placed at the beginning of the program to absorb mouse focus from the white space|
|CusButton|button|Some commonly used buttons have been encapsulated, and various effects can be customized again|
|CusCheckBox|CheckBox||
|CusComboBox|ComboBox||
|CusImage|Basic Image||
|CusInput|Input||
|CusLabel|Label||
|CusListView|List|Simaple custom scrollbars|
|CusPopup|Popup||
|CusScroll|ScrollBar||
|CusSlider|Slider||
|CusSpinBox|SpinBox||
|CusTable|Table|It needs to be used with specific C++ model to support the selection, check, draw rect selection, anti-selection, continuous selection and all selection|
|Effect|Effect|Animation、PageSwitch and ShaderToy|
|Misc|Others||



# Use TaoQuick 

## get code
```shell
git clone https://githun.com/jaredtao/TaoQuick.git
cd TaoQuick 
git submodule update --init
```

## qmake 

You just need import '.pri' file to project and add import Path to QmlEngine, TaoQuick will be use as local file or qrc resource.

Compared with 'Qml module' and 'Qml C++ plugin', this usage has the following advantages:

* After importing '.pri', no additional compile, generation of dll or plugin are required

* No additional copy resources are required to deployment the program

* After importing '.pri', Qt Creater can support TaoQuick Qml code highlighting and double-clicking the Follow symbol

* After import the module 'import TaoQuick 1.0' in Qml, you can use the TaoQuick component in The Designer mode of Qt Creater by dragging or visual property editor.(principle: Generate metainfo required by Designer via some script) 

![](https://github.com/jaredtao/TaoQuick/raw/master/preview/designer.png)

detail use step：

1. copy src/TaoQuick to your project, in any location

2. Import 'pri' files in the corresponding TaoQuick folder in your project 'pro' file

for eaxmple: 

```qmake
include(TaoQuick/TaoQuick.pri)
```

or

```qmake
include(src/TaoQuick/imports/imports.pri)
```

TaoQuick.pri will define two MACRO: TaoQuickImportPath and TaoQuickImagePath.

Debug mode will use TaoQuick as local file, and release mode for qrc resource.


3. add import path in cpp

  Before load source qml, TaoQuick need add import path to QmlEngine and set imagePath to context.

  if use QQuickView, TaoQuick can be use as flow:
   
```C++
    view.engine()->addImportPath(TaoQuickImportPath);
    view.rootContext()->setContextProperty("taoQuickImagePath", TaoQuickImagePath);
```

   if use QmlEngine, TaoQuick can be use as flow:

```C++
    engine.addImportPath(TaoQuickImportPath);
    engine.rootContext()->setContextProperty("taoQuickImagePath", TaoQuickImagePath);
```

***
## cmake

TaoQuick start support cmake after version 0.5.0 , it's same as qmake.

detail use step：

1. copy src/TaoQuick to your project, in any location

2. copy cmake/taoQuick.cmake to your project, in any location

and make sure the first line of taoQuick.cmake location to correct TaoQuick path

3. add cmake extern path in your CMakeLists.txt

add extern path:

```cmake
  SET(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
```
then load taoQuick by 'include'

```cmake
include(taoQuick)
```
taoQuick.cmake will define two MACRO: TaoQuickImportPath and TaoQuickImagePath.

Debug mode will use TaoQuick as local file, and release mode for qrc resource.

Release mode taoQuick.cmake also define a MACRO TaoQuickRes, that location to qrc file.

your project should add TaoQuickRes to executable, like this:

```cmake
if (CMAKE_BUILD_TYPE MATCHES "Release")
    add_executable(MyApp ${someSource} ${TaoQuickRes})
else()
    add_executable(MyApp ${someSource})
endif()
```
4. add import path in cpp

  Before load source qml, TaoQuick need add import path to QmlEngine and set imagePath to context.

  if use QQuickView, TaoQuick can be use as flow:
   
```C++
    view.engine()->addImportPath(TaoQuickImportPath);
    view.rootContext()->setContextProperty("taoQuickImagePath", TaoQuickImagePath);
```

   if use QmlEngine, TaoQuick can be use as flow:

```C++
    engine.addImportPath(TaoQuickImportPath);
    engine.rootContext()->setContextProperty("taoQuickImagePath", TaoQuickImagePath);
```