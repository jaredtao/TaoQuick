[English](README-en.md)

[github原始仓库https://github.com/jaredtao/TaoQuick](https://github.com/jaredtao/TaoQuick)

[gitee镜像仓库https://gitee.com/jaredtao/TaoQuick](https://gitee.com/jaredtao/TaoQuick)

-------------------------------------------------------------

# 目录

- [目录](#目录)
- [TaoQuick](#taoquick)
  - [徽章预览](#徽章预览)
    - [项目](#项目)
    - [编译](#编译)
    - [发布](#发布)
    - [仓库状态](#仓库状态)
    - [Issue](#issue)
    - [其它状态](#其它状态)
  - [部分Demo效果预览](#部分demo效果预览)
    - [启动界面](#启动界面)
    - [动态换皮肤](#动态换皮肤)
    - [百叶窗特效](#百叶窗特效)
    - [棋盘特效](#棋盘特效)
  - [全部效果预览](#全部效果预览)
  - [开发环境](#开发环境)
  - [功能列表](#功能列表)
  - [TaoQuick 安装和使用](#taoquick-安装和使用)
  - [联系作者](#联系作者)
  - [关注作者动态](#关注作者动态)
  - [寻找同道中人](#寻找同道中人)
  - [赞助](#赞助)
  - [赞助列表](#赞助列表)
  
# TaoQuick

这是一个QtQuick/Qml组件库，集成了常用的QtQuick组件，并做了适当的属性封装、功能扩展，以方便开发Qml程序。

实现原理可以参考《Qml组件化编程》《Qml特效》系列教程，以下网站都有收录:

[涛哥的博客](https://jaredtao.github.io)

[涛哥的博客-国内镜像](https://jaredtao.gitee.io)

[知乎专栏-Qt进阶之路](https://zhuanlan.zhihu.com/TaoQt)

## 徽章预览

### 项目

|[最佳实践计划][CII-link]|[许可][license-link]|
|:--:|:--:|
|![CII-badge]|![license-badge]|

[CII-badge]: https://bestpractices.coreinfrastructure.org/projects/3060/badge
[CII-link]: https://bestpractices.coreinfrastructure.org/projects/3060

[license-link]: https://github.com/jaredtao/TaoQuick/blob/master/LICENSE "LICENSE"
[license-badge]: https://img.shields.io/badge/license-MIT-blue.svg "MIT"

### 编译

| [Windows][win-link]| [Ubuntu][ubuntu-link]|[MacOS][macos-link]|[Android][android-link]|[IOS][ios-link]|
|---------------|---------------|-----------------|-----------------|----------------|
| ![win-badge]  | ![ubuntu-badge]      | ![macos-badge] |![android-badge]   |![ios-badge]   |


[win-link]: https://github.com/JaredTao/TaoQuick/actions?query=workflow%3AWindows "WindowsAction"
[win-badge]: https://github.com/JaredTao/TaoQuick/workflows/Windows/badge.svg  "Windows"

[ubuntu-link]: https://github.com/JaredTao/TaoQuick/actions?query=workflow%3AUbuntu "UbuntuAction"
[ubuntu-badge]: https://github.com/JaredTao/TaoQuick/workflows/Ubuntu/badge.svg "Ubuntu"

[macos-link]: https://github.com/JaredTao/TaoQuick/actions?query=workflow%3AMacOS "MacOSAction"
[macos-badge]: https://github.com/JaredTao/TaoQuick/workflows/MacOS/badge.svg "MacOS"

[android-link]: https://github.com/JaredTao/TaoQuick/actions?query=workflow%3AAndroid "AndroidAction"
[android-badge]: https://github.com/JaredTao/TaoQuick/workflows/Android/badge.svg "Android"

[ios-link]: https://github.com/JaredTao/TaoQuick/actions?query=workflow%3AIOS "IOSAction"
[ios-badge]: https://github.com/JaredTao/TaoQuick/workflows/IOS/badge.svg "IOS"

### 发布

|[已发布][release-link]|[下载][download-link]|下载次数|
|:--:|:--:|:--:|
|![release-badge] |![download-badge]|![download-latest]|

[release-link]: https://github.com/jaredtao/TaoQuick/releases "Release status"
[release-badge]: https://img.shields.io/github/release/jaredtao/TaoQuick.svg?style=flat-square "Release status"
[download-link]: https://github.com/jaredtao/TaoQuick/releases/latest "Download status"
[download-badge]: https://img.shields.io/github/downloads/jaredtao/TaoQuick/total.svg "Download status"
[download-latest]: https://img.shields.io/github/downloads/jaredtao/TaoQuick/latest/total.svg "latest status"

### 仓库状态

|最新标签|用到的编程语言数量|用最多的编程语言|代码大小|仓库大小|
|:--: |:--: |:--:|:--:|:--:|
|![tag-latest]|![languanges]|![taolanguage]|![code-size]|![repo-size]|

[languanges]: https://img.shields.io/github/languages/count/jaredtao/taoquick.svg "language count"
[taolanguage]: https://img.shields.io/github/languages/top/jaredtao/taoquick.svg "top language"
[code-size]: https://img.shields.io/github/languages/code-size/jaredtao/taoquick.svg "code size"
[repo-size]: https://img.shields.io/github/repo-size/jaredtao/taoquick.svg "repo-size"
[tag-latest]: https://img.shields.io/github/tag/jaredtao/taoquick.svg

### Issue
|[Issues][issues-link]|关掉的issue|pull请求|关掉的pull|
|:--:|:--:|:--:|:--:|
|![issuse-badge]|![issue-closed]|![pull-request]|![pull-closed]|

[issues-link]: https://github.com/jaredtao/TaoQuick/issues 
[issuse-badge]: https://img.shields.io/github/issues/jaredtao/taoquick.svg?style=popout 
[issue-closed]: https://img.shields.io/github/issues-closed/jaredtao/taoquick.svg
[pull-request]: https://img.shields.io/github/issues-pr/jaredtao/taoquick.svg
[pull-closed]: https://img.shields.io/github/issues-pr-closed/jaredtao/taoquick.svg

### 其它状态

|提交频率|最后一次提交|发布时间|forks|stars|
|:--:|:--:|:--:|:--:|:--:|
|![commit-active]|![commit-latest]|![release-date]|![forks-badge]|![stars-badge]|

[forks-badge]: https://img.shields.io/github/forks/jaredtao/taoquick.svg "forks"
[stars-badge]: https://img.shields.io/github/stars/jaredtao/taoquick.svg "stars"
[commit-active]: https://img.shields.io/github/commit-activity/w/jaredtao/taoquick.svg
[commit-latest]: https://img.shields.io/github/last-commit/jaredtao/taoquick.svg
[release-date]: https://img.shields.io/github/release-date/jaredtao/taoquick.svg


## 部分Demo效果预览

### 启动界面

![](https://gitee.com/jaredtao/TaoQuickPreview/blob/master/Preview/Splash.gif)

### 动态换皮肤

![](https://gitee.com/jaredtao/TaoQuickPreview/blob/master/Preview/Skin.gif)

### 百叶窗特效

![](https://gitee.com/jaredtao/TaoQuickPreview/blob/master/Preview/Animation/5.gif)

### 棋盘特效
![](https://gitee.com/jaredtao/TaoQuickPreview/blob/master/Preview/PageSwitch/棋盘效果.gif)

## 全部效果预览

gif太多，放进单独的仓库了[TaoQuickPreview](https://github.com/jaredtao/TaoQuickPreview)

也可以访问gitee镜像仓库 [TaoQuickPreview gitee](https://gitee.com/jaredtao/TaoQuickPreview)

## 开发环境

* Qt 5.12.x 以上

* 已兼容Qt5.15新版插件
 
## 功能列表
|用途|分类|名称|进度|说明|
|--|--|--|--|--|
|基础组件|-|-|-|-|
||按钮|-|-|-|
|||图片按钮|完成||
|||文字按钮|完成||
|||图文按钮|完成|左右或上下布局可调|
|||渐变背景按钮|完成|Material风格的圆角渐变背景|
||进度条|-|-|-|
|||条形进度条|完成|支持圆角、闪光效果、提示性文字或图片|
|||圆环进度条|完成||
||鼠标事件|-|-|-|
|||拖拽区域|完成||
|||透传区域|完成|透传鼠标事件|
||功能组件|-|-|-|
|||等待指示器|完成|小圆点数量、半径、颜色、转动速度都可以调节|
|||对话框|完成|单个组件支持创建文件、打开文件、打开文件夹、打开多个文件四种用法|
|||可拖动组件|完成|鼠标在边缘改变大小、鼠标在中间拖动改变位置|
|||帧率组件|完成|显示帧率|
|||提示框|完成|Slack风格，带三角箭头|
|自绘组件|-|-|-|-|
||Shapes自绘|-|-|-|
|||圆角矩形|完成|支持任意圆角、支持透明色|
|动画组件|-|-|-|-|
||进场动画|-|-|参考ppt的基础动画|
|||平移|完成|支持上、下、左、右四个方向|
|||梯度|完成|支持上、下、左、右四个方向|
|||劈裂|完成|支持水平由内、水平由外、垂直由内、垂直由外四种|
|||对角线|完成|支持从左上角、从右上角、从左下角、从右下角四种|
|||百叶窗|完成|支持上、下、左、右四个方向|
|||方盒|完成|支持由内、由外两种|
|||圆盒|完成|支持由内、由外两种|
|||十字|完成|支持由内、由外两种|
|||菱形|完成|支持由内、由外两种|
|||轮子|完成|支持顺时针、逆时针、扇形三种|
|||棋盘|完成|支持向右、向下两种|
|||溶解|完成||
|特效组件|-|-|-|-|
|||跟上节奏|完成|老式DVD上音符抖动的效果|
|||暗流涌动|完成|流动的箭头和倒影效果|
|||魔力圈圈|完成|爱的魔力转圈圈|
||ShaderToy|-|-|在Android上测试过|
|||穿云洞|完成||
|||星球之光|完成||
|||蜗牛|完成||
|||超级马里奥|完成||
|研究性组件|-|-|-|-|
|||圆环视图|研究中||
|||流体效果|研究中||


## TaoQuick 安装和使用

[TaoQuick 安装和使用](Install.md)


***

## 联系作者

作者：武威的涛哥

欢迎联系我，乐于提供技术咨询服务，可洽谈技术支持、商业合作。

邮箱:  jared2020@163.com            

微信:  xsd2410421 

QQ: 759378563

<img src="https://gitee.com/jaredtao/jaredtao/raw/master/img/weixin_connect.jpg?raw=true" width="30.35%" height="30%" /><img src="https://gitee.com/jaredtao/jaredtao/raw/master/img/qq_connect.jpg?raw=true" width="28%" height="28%" />

*** 
## 关注作者动态

欢迎关注涛哥的微信公众号： Qt进阶之路

不定期分享Qt相关的高质量教程

<img src="https://gitee.com/jaredtao/jaredtao/raw/master/img/weixingongzhonghao.jpg?raw=true" width="28%" height="28%" />

*****
## 寻找同道中人

欢迎加入涛哥的QQ群: Qt进阶之路 

此群是高质量群，Qt界大佬众多，不灌水闲聊，日常交流技术、分享书籍、帮助解决实际问题。

1群：734623697(已满)

2群：342341405



<img src="https://gitee.com/jaredtao/jaredtao/raw/master/img/qqgroup.jpg?raw=true" width="28%" height="28%" /><img src="https://gitee.com/jaredtao/jaredtao/raw/master/img/qqgroup2.jpg?raw=true" width="28%" height="28%" />

******

## 赞助


 觉得分享的内容还不错, 就请作者喝杯奶茶吧~~


<img src="https://gitee.com/jaredtao/jaredtao/raw/master/img/weixin.jpg?raw=true" width="30%" height="30%" /><img src="https://gitee.com/jaredtao/jaredtao/raw/master/img/zhifubao.jpg?raw=true" width="30%" height="30%" />


## 赞助列表

感谢以下网友的赞助与支持(排名不分先后)：

hxhlb (花心胡萝卜工作室)

咸鱼猴

Qt侠-刘典武

一去、二三里

大樹

丝绸-郑天佐

寒山-居士

小风电子

Qt君

海盗船

雨田哥

游龙

Rj

重庆-胡某某

Ivy

孙十一少

田宇

power

敢敢

扣脚翁

白菜豆腐

甜不辣

Mr.Hu

秾芳教主

焖哥

蓝色幻想

Martin Zuo

windsmoon

小手冰凉

永远=没有终点

我是王大狗

米粒旅行