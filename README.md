# XTILogerManager

[![CI Status](https://img.shields.io/travis/xt-input/XTILogerManager.svg?style=flat)](https://travis-ci.org/xt-input/XTILogerManager)
[![Version](https://img.shields.io/cocoapods/v/XTILogerManager.svg?style=flat)](https://cocoapods.org/pods/XTILogerManager)
[![License](https://img.shields.io/cocoapods/l/XTILogerManager.svg?style=flat)](https://cocoapods.org/pods/XTILogerManager)
[![Platform](https://img.shields.io/cocoapods/p/XTILogerManager.svg?style=flat)](https://cocoapods.org/pods/XTILogerManager)

使用方法：
```
    XTILoger_Debug(@"%@__%@",@"日志测试",self);
    XTILoger_Info(@"%@__%@",@"日志测试",self);
    XTILoger_Warning(@"%@__%@",@"日志测试",self);
    XTILoger_Error(@"%@__%@",@"日志测试",self);
    XTILoger_Crash(@"%@__%@",@"日志测试",self);
```
效果：
```
2020-04-20 09:55:41.996079+0800 XTILogerManagerDemo[54805:6806843] [debug] ViewController.m:32 > 日志测试__<ViewController: 0x7fb6e8105320>
2020-04-20 09:55:41.996291+0800 XTILogerManagerDemo[54805:6806843] [info] ViewController.m:33 > 日志测试__<ViewController: 0x7fb6e8105320>
2020-04-20 09:55:41.996484+0800 XTILogerManagerDemo[54805:6806843] [warning] ViewController.m:34 > 日志测试__<ViewController: 0x7fb6e8105320>
2020-04-20 09:55:41.996622+0800 XTILogerManagerDemo[54805:6806843] [error] ViewController.m:35 > 日志测试__<ViewController: 0x7fb6e8105320>
2020-04-20 09:55:41.998184+0800 XTILogerManagerDemo[54805:6806843] [crash] 日志测试__<ViewController: 0x7fb6e8105320>
```
