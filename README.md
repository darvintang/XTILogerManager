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
2018-06-17 20:29:14.177867+0800 XTILogerManager[5685:2785897] [debug] ViewController.m:43 > 日志测试__<ViewController: 0x151d05a70>
2018-06-17 20:29:14.182777+0800 XTILogerManager[5685:2785898] [info] ViewController.m:44 > 日志测试__<ViewController: 0x151d05a70>
2018-06-17 20:29:14.183181+0800 XTILogerManager[5685:2785898] [warning] ViewController.m:45 > 日志测试__<ViewController: 0x151d05a70>
2018-06-17 20:29:14.183701+0800 XTILogerManager[5685:2785898] [error] ViewController.m:46 > 日志测试__<ViewController: 0x151d05a70>
2018-06-17 20:29:14.184396+0800 XTILogerManager[5685:2785898] [crash] ViewController.m:47 > 日志测试__<ViewController: 0x151d05a70>
```
