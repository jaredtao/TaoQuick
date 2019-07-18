# 目录
- [目录](#%E7%9B%AE%E5%BD%95)
- [TaoQuick](#TaoQuick)
  - [徽章预览](#%E5%BE%BD%E7%AB%A0%E9%A2%84%E8%A7%88)
    - [CI](#CI)
    - [Repo](#Repo)
    - [Issue](#Issue)
    - [Other status](#Other-status)
  - [开发环境](#%E5%BC%80%E5%8F%91%E7%8E%AF%E5%A2%83)
  - [效果预览](#%E6%95%88%E6%9E%9C%E9%A2%84%E8%A7%88)
    - [启动界面](#%E5%90%AF%E5%8A%A8%E7%95%8C%E9%9D%A2)
    - [动态换皮肤](#%E5%8A%A8%E6%80%81%E6%8D%A2%E7%9A%AE%E8%82%A4)
    - [百叶窗特效](#%E7%99%BE%E5%8F%B6%E7%AA%97%E7%89%B9%E6%95%88)
    - [棋盘特效](#%E6%A3%8B%E7%9B%98%E7%89%B9%E6%95%88)
    - [ShaderToy-超级马里奥](#ShaderToy-%E8%B6%85%E7%BA%A7%E9%A9%AC%E9%87%8C%E5%A5%A5)
    - [Qml 安卓简易热加载](#Qml-%E5%AE%89%E5%8D%93%E7%AE%80%E6%98%93%E7%83%AD%E5%8A%A0%E8%BD%BD)
    - [更多基础效果预览](#%E6%9B%B4%E5%A4%9A%E5%9F%BA%E7%A1%80%E6%95%88%E6%9E%9C%E9%A2%84%E8%A7%88)
    - [动画效果预览](#%E5%8A%A8%E7%94%BB%E6%95%88%E6%9E%9C%E9%A2%84%E8%A7%88)
    - [页面切换效果预览](#%E9%A1%B5%E9%9D%A2%E5%88%87%E6%8D%A2%E6%95%88%E6%9E%9C%E9%A2%84%E8%A7%88)
    - [ShaderToy效果预览](#ShaderToy%E6%95%88%E6%9E%9C%E9%A2%84%E8%A7%88)
    - [其它特效](#%E5%85%B6%E5%AE%83%E7%89%B9%E6%95%88)
  - [TaoQuick 安装和使用](#TaoQuick-%E5%AE%89%E8%A3%85%E5%92%8C%E4%BD%BF%E7%94%A8)
  - [联系方式](#%E8%81%94%E7%B3%BB%E6%96%B9%E5%BC%8F)
  - [赞助](#%E8%B5%9E%E5%8A%A9)
# TaoQuick

这是一个Qt/Qml组件库，集成了常用的QtQuick组件，并做了适当的属性封装、功能扩展，以方便开发Qml程序。

实现原理可以参考《Qml组件化编程》《Qml特效》系列教程，以下网站都有收录:

[涛哥的博客](https://jaredtao.github.io)

[知乎专栏-Qt进阶之路](https://zhuanlan.zhihu.com/TaoQt)

微信公众号： Qt进阶之路

## 徽章预览
### CI
|[License][license-link]| [Ubuntu/MacOS][lin-link] | [Windows][win-link] |[Release][release-link]|[Download][download-link]|latest|
|:--:|:--:|:--:|:--:|:--:|:--:|
|![license-badge]| ![lin-badge]| ![win-badge]|![release-badge] |![download-badge]|![download-latest]|

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

### Repo 
|latest tag|languages|top language|code size|repo size|
|:--: |:--: |:--:|:--:|:--:|
|![tag-latest]|![languanges]|![taolanguage]|![code-size]|![repo-size]|

[languanges]: https://img.shields.io/github/languages/count/jaredtao/taoquick.svg "language count"
[taolanguage]: https://img.shields.io/github/languages/top/jaredtao/taoquick.svg "top language"
[code-size]: https://img.shields.io/github/languages/code-size/jaredtao/taoquick.svg "code size"
[repo-size]: https://img.shields.io/github/repo-size/jaredtao/taoquick.svg "repo-size"
[tag-latest]: https://img.shields.io/github/tag/jaredtao/taoquick.svg

### Issue
|[Issues][issues-link]|closed issue|pull request|pull closed|
|:--:|:--:|:--:|:--:|
|![issuse-badge]|![issue-closed]|![pull-request]|![pull-closed]|

[issues-link]: https://github.com/jaredtao/TaoQuick/issues 
[issuse-badge]: https://img.shields.io/github/issues/jaredtao/taoquick.svg?style=popout 
[issue-closed]: https://img.shields.io/github/issues-closed/jaredtao/taoquick.svg
[pull-request]: https://img.shields.io/github/issues-pr/jaredtao/taoquick.svg
[pull-closed]: https://img.shields.io/github/issues-pr-closed/jaredtao/taoquick.svg

### Other status

|commit-active|laste commit|release date|forks|stars|goto hit|
|:--:|:--:|:--:|:--:|:--:|:--:|
|![commit-active]|![commit-latest]|![release-date]|![forks-badge]|![stars-badge]|![goto-hit]|

[forks-badge]: https://img.shields.io/github/forks/jaredtao/taoquick.svg "forks"
[stars-badge]: https://img.shields.io/github/stars/jaredtao/taoquick.svg "stars"
[goto-hit]: https://img.shields.io/github/search/jaredtao/taoquick/goto.svg "goto-hit"
[commit-active]: https://img.shields.io/github/commit-activity/w/jaredtao/taoquick.svg
[commit-latest]: https://img.shields.io/github/last-commit/jaredtao/taoquick.svg
[release-date]: https://img.shields.io/github/release-date/jaredtao/taoquick.svg

## 开发环境

* Qt 5.12.x

## 效果预览

### 启动界面

![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/Splash.gif)

### 动态换皮肤

![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/Skin.gif)

### 百叶窗特效

![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/Animation/5.gif)

### 棋盘特效
![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/PageSwitch/棋盘效果.gif)

### ShaderToy-超级马里奥
![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/ShaderToy/Preview4.gif)

### Qml 安卓简易热加载

![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/Hotload2.gif)

说明：简易热加载功能，正在完善中。整个TaoQuick将支持热加载。


预览效果太多，浏览器会卡，放进单独的Markdown
### 更多基础效果预览

[基础效果预览](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview-normal.md)

### 动画效果预览

[动画效果预览](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview-animation.md)

说明：动画效果暂不开源，博客/知乎/公众号会有教程和核心代码，有需要请单独联系我。

### 页面切换效果预览
[页面切换效果预览](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview-PageSwitch.md)

说明：页面切换效果暂不开源，博客/知乎/公众号会有教程和核心代码，有需要请单独联系我。
### ShaderToy效果预览

[ShaderToy效果预览](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview-ShaderToy.md)

### 其它特效

[其它特效](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview-Effect.md)

## TaoQuick 安装和使用

[TaoQuick 安装和使用](Install.md)

## 联系方式

***

| 作者 | 涛哥                           |
| ---- | -------------------------------- |
|开发理念 | 弘扬鲁班文化，传承工匠精神 |
| 博客 | https://jaredtao.github.io/ |
|知乎专栏| https://zhuanlan.zhihu.com/TaoQt |
|微信公众号| Qt进阶之路 |
|QQ群| 734623697(高质量群，只能交流技术、分享知识、帮助解决实际问题）|
| 邮箱 | jared2020@163.com                |
| 微信 | xsd2410421                       |
| QQ、TIM | 759378563                      |
***

QQ(TIM)、微信二维码

<img src="https://github.com/jaredtao/jaredtao.github.io/blob/master/img/qq_connect.jpg?raw=true" width="30%" height="30%" /><img src="https://github.com/jaredtao/jaredtao.github.io/blob/master/img/weixin_connect.jpg?raw=true" width="30%" height="30%" />


****** 请放心联系我，乐于提供咨询服务，也可洽谈有偿技术支持相关事宜。

***
## 赞助
<img src="https://github.com/jaredtao/jaredtao.github.io/blob/master/img/weixin.jpg?raw=true" width="30%" height="30%" /><img src="https://github.com/jaredtao/jaredtao.github.io/blob/master/img/zhifubao.jpg?raw=true" width="30%" height="30%" />

****** 觉得分享的内容还不错, 就请作者喝杯奶茶吧~~
***

