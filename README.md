[tag download]:https://github.com/Jieli-Tech/ios-bt-demo/tags
[tag_badgen]:https://img.shields.io/badge/Tag-v1.0.0-informational?style=plastic&logo=iOS&labelColor=ffffff&logoColor=blue

# iOS-BT-Demo  [![tag][tag_badgen]][tag download]

<div align="center">

**杰理蓝牙产品 iOS 端测试示例代码集合，方便客户快速测试蓝牙功能。**

[iOS](https://img.shields.io/badge/iOS-13.0+-blue.svg)
[Xcode](https://img.shields.io/badge/Xcode-14.0+-orange.svg)
[License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)

[中文](./README.md) · [English](./README_EN.md) · [文档中心](https://doc.zh-jieli.com/Apps/iOS/ota/zh-cn/master/Development/Content/gatt_over_edr_desc.html#gatt-over-edr) · [版本历史](#七版本历史) · [报告问题](https://github.com/Jieli-Tech/ios-bt-demo/issues)

</div>

---

## 📋 目录

- [一、概述](#一概述)
- [二、支持的平台与设备](#二支持的平台与设备)
- [三、快速开始](#三快速开始)
- [四、工程结构](#四工程结构)
- [五、示例选择指南](#五示例选择指南)
- [六、社区与支持](#六社区与支持)
- [七、版本历史](#七版本历史)
- [八、许可证](#八许可证)

---

## 一、概述

`iOS-BT-Demo` 是珠海杰理科技股份有限公司为蓝牙产品提供的 iOS 端测试示例代码集合仓库。

本仓库包含以下用例:

*  GATT Over BR/EDR 连接示例，演示了如何在 iOS 端通过 GATT 协议与杰理蓝牙产品进行数据通讯。

---

## 二、支持的平台与设备

### 2.1 iOS 系统要求

| 项目 | 说明 |
|------|------|
| **最低版本** | iOS 13.0 |
| **目标版本** | iOS 16+ |
| **开发语言** | Swift / Objective-C |

### 2.2 支持的蓝牙协议

| 协议 | 说明 | 状态 |
|------|------|------|
| GATT over BR/EDR | 基于经典蓝牙的 GATT 通讯，速率更高 | ✅ 支持 |

> **注意**：iOS 端对 GATT over BR/EDR 功能的支持需要 iOS 13+，建议在目标设备上进行充分测试。

---

## 三、快速开始

### 3.1 克隆仓库

```bash
git clone https://github.com/Jieli-Tech/ios-bt-demo.git
cd ios-bt-demo
```

### 3.2 选择合适的示例

根据你的产品需求选择示例工程：

```
ios-bt-demo/
├── UsingCoreBluetoothClassic/       # GATT Over BR/EDR 连接示例
└── .../              # 更多示例持续更新中
```

### 3.3 导入并运行

1. 打开 **Xcode**
2. 点击 **File → Open**，选择对应的示例目录（如 `UsingCoreBluetoothClassic/`）
3. 等待项目加载完成
4. 连接 iOS 设备或选择模拟器，点击 **Product → Run**
5. 在设备上打开 APP，测试蓝牙功能

---

## 四、工程结构

```
ios-bt-demo/
├── UsingCoreBluetoothClassic/                          # 📌 ATT 设备连接示例
├── LICENSE.txt                              # Apache 2.0 开源协议
└── README.md
```



* [UsingCoreBluetoothClassic](https://github.com/Jieli-Tech/ios-bt-demo/tree/main/UsingCoreBluetoothClassic) --- GATT Over BR/EDR 连接示例



---

## 五、示例选择指南

### 5.1 GATT Over BR/EDR 连接示例（`UsingCoreBluetoothClassic/`）

| 项目 | 说明 |
|------|------|
| **适用场景** | 蓝牙设备（经典蓝牙 ），需要通过 GATT 协议进行高速数据通讯 |
| **关键特性** | GATT over BR/EDR 连接/断开管理、数据收发、GATT 服务发现 |
| **核心类** | `CBCentralManager`（蓝牙扫描）、`CBPeripheral`（外设管理） |
| **参考文档** | [UsingCoreBluetoothClassic 详细说明](UsingCoreBluetoothClassic/README.md) |




---

## 六、社区与支持

### 技术交流

| 平台 | 群号/链接 | 状态 |
|------|-----------|------|
| **GitHub** | [Jieli-Tech](https://github.com/Jieli-Tech) | ✅ 活跃 |
| **问题反馈** | [提交 Issue](https://github.com/Jieli-Tech/ios-bt-demo/issues) | ✅ 开放 |

### 资源链接

| 资源 | 链接 |
|------|------|
| 📖 **在线文档中心** | [https://doc.zh-jieli.com/vue](https://doc.zh-jieli.com/vue/#/home) |
| 🐛 **问题反馈** | [GitHub Issues](https://github.com/Jieli-Tech/ios-bt-demo/issues) |

---



## 七、版本历史

| 版本  | 日期       | 修改记录           |
| ----- | ---------- | ------------------ |
| 1.0.0 | 2025/03/32 | 1. 新增 UsingCoreBluetoothClassic 连接示例 |



## 八、许可证

本项目采用 [Apache License 2.0](./LICENSE) 开源协议。

```
Copyright 2025 珠海市杰理科技股份有限公司

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```



<div align="center">


   **© 2025 珠海市杰理科技股份有限公司 | Licensed under Apache License 2.0**

</div>