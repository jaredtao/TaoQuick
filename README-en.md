[简体中文](README.md)

-------------------------------------------------------------

# catalogue
- [catalogue](#catalogue)
- [TaoQuick](#taoquick)
  - [Badge preview](#badge-preview)
    - [Project Status](#project-status)
    - [Repository status](#repository-status)
    - [Issue](#issue)
    - [Other status](#other-status)
  - [Some Demo Preview](#some-demo-preview)
    - [Splash](#splash)
    - [Change Skin](#change-skin)
    - [Shutters](#shutters)
    - [Chess](#chess)
  - [All effect preview](#all-effect-preview)
  - [Functions List](#functions-list)
  - [Qt Version](#qt-version)
  - [Install](#install)
  - [Sponsorship](#sponsorship)
  
# TaoQuick

This is a QtQuick/Qml Component library, integrated some commonly used QtQuick components, and 

make the appropriate function expansion to  facilitate development of Qml applications.

## Badge preview
### Project Status
|[Best Practices plan][CII-link]|[License][license-link]| [Ubuntu/MacOS][lin-link] | [Windows][win-link] |[Released][release-link]|[Download][download-link]|Download count|
|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
|![CII-badge]|![license-badge]|![lin-badge]| ![win-badge]|![release-badge] |![download-badge]|![download-latest]|

[license-link]: https://github.com/jaredtao/TaoQuick/blob/master/LICENSE "LICENSE"
[license-badge]: https://img.shields.io/badge/license-MIT-blue.svg "MIT"

[lin-badge]: https://travis-ci.com/jaredtao/TaoQuick.svg?branch=master "Travis build status"
[lin-link]: https://travis-ci.com/jaredtao/TaoQuick "Travis build status"
[win-badge]: https://ci.appveyor.com/api/projects/status/ontim37g33hvfv72?svg=true "AppVeyor build status"
[win-link]: https://ci.appveyor.com/project/jiawentao/TaoQuick "AppVeyor build status"

[release-link]: https://github.com/jaredtao/TaoQuick/releases "Release status"
[release-badge]: https://img.shields.io/github/release/jaredtao/TaoQuick.svg?style=flat-square "Release status"
[download-link]: https://github.com/jaredtao/TaoQuick/releases/latest "Download status"
[download-badge]: https://img.shields.io/github/downloads/jaredtao/TaoQuick/total.svg "Download status"
[download-latest]: https://img.shields.io/github/downloads/jaredtao/TaoQuick/latest/total.svg "latest status"
[CII-badge]: https://bestpractices.coreinfrastructure.org/projects/3060/badge
[CII-link]: https://bestpractices.coreinfrastructure.org/projects/3060
### Repository status
|Tag|Languages|Top Language|code size|repo size|
|:--: |:--: |:--:|:--:|:--:|
|![tag-latest]|![languanges]|![taolanguage]|![code-size]|![repo-size]|

[languanges]: https://img.shields.io/github/languages/count/jaredtao/taoquick.svg "language count"
[taolanguage]: https://img.shields.io/github/languages/top/jaredtao/taoquick.svg "top language"
[code-size]: https://img.shields.io/github/languages/code-size/jaredtao/taoquick.svg "code size"
[repo-size]: https://img.shields.io/github/repo-size/jaredtao/taoquick.svg "repo-size"
[tag-latest]: https://img.shields.io/github/tag/jaredtao/taoquick.svg

### Issue
|[Issues][issues-link]|pull request|
|:--:|:--:|
|![issuse-badge]|![pull-request]|

[issues-link]: https://github.com/jaredtao/TaoQuick/issues 
[issuse-badge]: https://img.shields.io/github/issues/jaredtao/taoquick.svg?style=popout 
[issue-closed]: https://img.shields.io/github/issues-closed/jaredtao/taoquick.svg
[pull-request]: https://img.shields.io/github/issues-pr/jaredtao/taoquick.svg
[pull-closed]: https://img.shields.io/github/issues-pr-closed/jaredtao/taoquick.svg

### Other status

|commit freq|last commit|date|forks|stars|
|:--:|:--:|:--:|:--:|:--:|
|![commit-active]|![commit-latest]|![release-date]|![forks-badge]|![stars-badge]|

[forks-badge]: https://img.shields.io/github/forks/jaredtao/taoquick.svg "forks"
[stars-badge]: https://img.shields.io/github/stars/jaredtao/taoquick.svg "stars"
[commit-active]: https://img.shields.io/github/commit-activity/w/jaredtao/taoquick.svg
[commit-latest]: https://img.shields.io/github/last-commit/jaredtao/taoquick.svg
[release-date]: https://img.shields.io/github/release-date/jaredtao/taoquick.svg


## Some Demo Preview

### Splash

![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/Splash.gif)

### Change Skin

![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/Skin.gif)

### Shutters

![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/Animation/5.gif)

### Chess

![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/PageSwitch/棋盘效果.gif)

## All effect preview

There are too many 'gif' files, In a separate repo [TaoQuickPreview](https://github.com/jaredtao/TaoQuickPreview)

## Functions List
|Use|Category|Name|Progress|Note|
|--|--|--|--|--|
|Base Component|-|-|-|-|
||Button|-|-|-|
|||ImageButton|Complete||
|||TextButton|Complete||
|||TextImageButton|Complete|support left-right or top-bottom layout|
|||GradiantButton|Complete|RoundButton with gradient background Material style|
||ProgressBar|-|-|-|
|||NormalBar|Complete|RoundCorner、flicker、custom text or image|
|||CircleBar|Complete||
||MouseArea|-|-|-|
|||DragMoveArea|Complete||
|||TransparentArea|Complete|transport mouse event|
||Function Component|-|-|-|
|||Indicator|Complete|can set little point count、radis、color、rotate speed|
|||Dialog|Complete|one component support 4 usage of 'create file','open file','open folder' and 'open mulit files'|
|||DragMoveItem|Complete|Mouse drag to change size and position|
|||FPS|Complete|FPS|
|||TipDialog|Complete|Slack style tip|
|CustomDraw|-|-|-|-|
||Shapes|-|-|-|
|||RoundRectangle|Complete|any of 4 corner can be rounded, support transparent background|
|Animation Component|-|-|-|-|
||EnterAnimation|-|-|Reference to ppt animation effect|
|||move|Complete|support up, down, left, right direction|
|||Grad show|Complete|up, down, left, right|
|||Cleavage|Complete|from Inner, from Outter|
|||Diagonal|Complete|top-Left,top-Right, bottom-left, bottom-right|
|||Louver|Complete|up, down, left, right|
|||Square|Complete|from Inner, from Outter|
|||Circle|Complete|from Inner, from Outter|
|||Cross|Complete|from Inner, from Outter|
|||Rhombus|Complete|from Inner, from Outter|
|||Wheel|Complete|Clockwise,CounterClockwise|
|||Board|Complete|to right, to bottom|
|||Dissolve|Complete||
|Special Effect|-|-|-|-|
|||Follow rhythm|Complete||
|||Arrow Flow|Complete||
|||magic circle|Complete||
||ShaderToy|-|-|support android|
|||Cloud Hole|Complete||
|||Planet|Complete||
|||Snail|Complete||
|||Super Mario|Complete||

## Qt Version

* Qt 5.12.x

## Install 

[TaoQuick Install and use](Install-en.md)

## Sponsorship

If you feel the share content is good, treat the author a drink.

<img src="https://github.com/jaredtao/jaredtao.github.io/blob/master/img/weixin.jpg?raw=true" width="30%" height="30%" /><img src="https://github.com/jaredtao/jaredtao.github.io/blob/master/img/zhifubao.jpg?raw=true" width="30%" height="30%" />

it's WeChat Pay and Alipay
