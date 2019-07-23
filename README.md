# 目录
- [目录](#%e7%9b%ae%e5%bd%95)
- [TaoQuick](#taoquick)
  - [徽章预览](#%e5%be%bd%e7%ab%a0%e9%a2%84%e8%a7%88)
    - [CI](#ci)
    - [Repo](#repo)
    - [Issue](#issue)
    - [Other status](#other-status)
  - [开发环境](#%e5%bc%80%e5%8f%91%e7%8e%af%e5%a2%83)
  - [效果预览](#%e6%95%88%e6%9e%9c%e9%a2%84%e8%a7%88)
    - [启动界面](#%e5%90%af%e5%8a%a8%e7%95%8c%e9%9d%a2)
    - [动态换皮肤](#%e5%8a%a8%e6%80%81%e6%8d%a2%e7%9a%ae%e8%82%a4)
    - [百叶窗特效](#%e7%99%be%e5%8f%b6%e7%aa%97%e7%89%b9%e6%95%88)
    - [棋盘特效](#%e6%a3%8b%e7%9b%98%e7%89%b9%e6%95%88)
    - [ShaderToy-超级马里奥](#shadertoy-%e8%b6%85%e7%ba%a7%e9%a9%ac%e9%87%8c%e5%a5%a5)
    - [Qml 安卓简易热加载](#qml-%e5%ae%89%e5%8d%93%e7%ae%80%e6%98%93%e7%83%ad%e5%8a%a0%e8%bd%bd)
    - [更多基础效果预览](#%e6%9b%b4%e5%a4%9a%e5%9f%ba%e7%a1%80%e6%95%88%e6%9e%9c%e9%a2%84%e8%a7%88)
    - [动画效果预览](#%e5%8a%a8%e7%94%bb%e6%95%88%e6%9e%9c%e9%a2%84%e8%a7%88)
    - [页面切换效果预览](#%e9%a1%b5%e9%9d%a2%e5%88%87%e6%8d%a2%e6%95%88%e6%9e%9c%e9%a2%84%e8%a7%88)
    - [ShaderToy效果预览](#shadertoy%e6%95%88%e6%9e%9c%e9%a2%84%e8%a7%88)
    - [其它特效](#%e5%85%b6%e5%ae%83%e7%89%b9%e6%95%88)
  - [TaoQuick 安装和使用](#taoquick-%e5%ae%89%e8%a3%85%e5%92%8c%e4%bd%bf%e7%94%a8)
  - [联系方式](#%e8%81%94%e7%b3%bb%e6%96%b9%e5%bc%8f)
  - [赞助](#%e8%b5%9e%e5%8a%a9)
  - [赞助列表](#%e8%b5%9e%e5%8a%a9%e5%88%97%e8%a1%a8)
  
# TaoQuick

这是一个QtQuick/Qml组件库，集成了常用的QtQuick组件，并做了适当的属性封装、功能扩展，以方便开发Qml程序。

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

ShaderToy效果已开源，且支持安卓。也可以在单独的仓库中看到：[https://github.com/jaredtao/TaoShaderToy](https://github.com/jaredtao/TaoShaderToy)

### 其它特效

[其它特效](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview-Effect.md)

收集一些在网络上看到的比较有意思的效果。

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
|QQ群| 734623697(高质量群，只能交流技术、分享书籍、帮助解决实际问题）|
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

## 赞助列表

感谢以下网友的赞助与支持(排名不分先后)：

hxhlb (花心胡萝卜工作室)

咸鱼猴

Qt侠-刘典武

大樹

小风电子
