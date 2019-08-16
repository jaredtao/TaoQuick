# 目录
- [目录](#%e7%9b%ae%e5%bd%95)
- [TaoQuick](#taoquick)
  - [徽章预览](#%e5%be%bd%e7%ab%a0%e9%a2%84%e8%a7%88)
    - [持续集成状态](#%e6%8c%81%e7%bb%ad%e9%9b%86%e6%88%90%e7%8a%b6%e6%80%81)
    - [仓库状态](#%e4%bb%93%e5%ba%93%e7%8a%b6%e6%80%81)
    - [Issue](#issue)
    - [其它状态](#%e5%85%b6%e5%ae%83%e7%8a%b6%e6%80%81)
  - [部分Demo效果预览](#%e9%83%a8%e5%88%86demo%e6%95%88%e6%9e%9c%e9%a2%84%e8%a7%88)
    - [启动界面](#%e5%90%af%e5%8a%a8%e7%95%8c%e9%9d%a2)
    - [动态换皮肤](#%e5%8a%a8%e6%80%81%e6%8d%a2%e7%9a%ae%e8%82%a4)
    - [百叶窗特效](#%e7%99%be%e5%8f%b6%e7%aa%97%e7%89%b9%e6%95%88)
    - [棋盘特效](#%e6%a3%8b%e7%9b%98%e7%89%b9%e6%95%88)
  - [全部效果预览](#%e5%85%a8%e9%83%a8%e6%95%88%e6%9e%9c%e9%a2%84%e8%a7%88)
  - [功能列表](#%e5%8a%9f%e8%83%bd%e5%88%97%e8%a1%a8)
  - [开发环境](#%e5%bc%80%e5%8f%91%e7%8e%af%e5%a2%83)
  - [TaoQuick 安装和使用](#taoquick-%e5%ae%89%e8%a3%85%e5%92%8c%e4%bd%bf%e7%94%a8)
  - [联系方式](#%e8%81%94%e7%b3%bb%e6%96%b9%e5%bc%8f)
  - [赞助](#%e8%b5%9e%e5%8a%a9)
  - [赞助列表](#%e8%b5%9e%e5%8a%a9%e5%88%97%e8%a1%a8)
  
# TaoQuick

这是一个QtQuick/Qml组件库，集成了常用的QtQuick组件，并做了适当的属性封装、功能扩展，以方便开发Qml程序。

实现原理可以参考《Qml组件化编程》《Qml特效》系列教程，以下网站都有收录:

[涛哥的博客](https://jaredtao.github.io)

[涛哥的博客-国内镜像](https://jaredtao.gitee.io)

[知乎专栏-Qt进阶之路](https://zhuanlan.zhihu.com/TaoQt)

微信公众号： Qt进阶之路

## 徽章预览
### 项目状态
|[最佳实践计划][CII-link]|[许可][license-link]| [Ubuntu/MacOS][lin-link] | [Windows][win-link] |[已发布][release-link]|[下载][download-link]|下载次数|
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

![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/Splash.gif)

### 动态换皮肤

![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/Skin.gif)

### 百叶窗特效

![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/Animation/5.gif)

### 棋盘特效
![](https://github.com/jaredtao/TaoQuickPreview/blob/master/Preview/PageSwitch/棋盘效果.gif)

## 全部效果预览

gif太多，放进单独的仓库了[TaoQuickPreview](https://github.com/jaredtao/TaoQuickPreview)

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

## 开发环境

* Qt 5.12.x

## TaoQuick 安装和使用

[TaoQuick 安装和使用](Install.md)

## 联系方式

***

| 作者 | 涛哥                           |
| ---- | -------------------------------- |
|开发理念 | 弘扬鲁班文化，传承工匠精神 |
| 博客 | https://jaredtao.github.io/ |
|博客-国内镜像|https://jaredtao.gitee.io|
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
