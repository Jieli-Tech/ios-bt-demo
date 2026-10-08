[tag download]:https://github.com/Jieli-Tech/ios-bt-demo/tags
[tag_badgen]:https://img.shields.io/badge/Tag-v1.0.0-informational?style=plastic&logo=iOS&labelColor=ffffff&logoColor=blue

# iOS-BT-Demo  [![tag][tag_badgen]][tag download]

<div align="center">

**Bluetooth product iOS test example code collection from Jieli, convenient for quick Bluetooth function testing.**

[iOS](https://img.shields.io/badge/iOS-13.0+-blue.svg)
[Xcode](https://img.shields.io/badge/Xcode-14.0+-orange.svg)
[License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)

[中文](./README.md) · [English](./README_EN.md) · [Documentation](https://doc.zh-jieli.com/Apps/iOS/ota/zh-cn/master/Development/Content/gatt_over_edr_desc.html#gatt-over-edr) · [Version History](#7-version-history) · [Report Issue](https://github.com/Jieli-Tech/ios-bt-demo/issues)

</div>

---

## 📋 Table of Contents

- [1. Overview](#1-overview)
- [2. Supported Platforms and Devices](#2-supported-platforms-and-devices)
- [3. Getting Started](#3-getting-started)
- [4. Project Structure](#4-project-structure)
- [5. Example Selection Guide](#5-example-selection-guide)
- [6. Community and Support](#6-community-and-support)
- [7. Version History](#7-version-history)
- [8. License](#8-license)

---

## 1. Overview

`iOS-BT-Demo` is a collection of iOS test example codes for Bluetooth products provided by Jieli Technology Co., Ltd. (Zhuhai).

This repository includes the following use cases:

*  GATT Over BR/EDR connection example, demonstrating how to communicate with Jieli Bluetooth products via GATT protocol on iOS.

---

## 2. Supported Platforms and Devices

### 2.1 iOS System Requirements

| Item | Description |
|------|------|
| **Minimum Version** | iOS 13.0 |
| **Target Version** | iOS 16+ |
| **Development Language** | Swift / Objective-C |

### 2.2 Supported Bluetooth Protocols

| Protocol | Description | Status |
|------|------|------|
| GATT over BR/EDR | GATT communication based on Classic Bluetooth, higher speed | ✅ Supported |

> **Note**: iOS support for GATT over BR/EDR requires iOS 13+, recommend thorough testing on target devices.

---

## 3. Getting Started

### 3.1 Clone Repository

```bash
git clone https://github.com/Jieli-Tech/ios-bt-demo.git
cd ios-bt-demo
```

### 3.2 Select Appropriate Example

Select example project based on your product requirements:

```
ios-bt-demo/
├── UsingCoreBluetoothClassic/       # GATT Over BR/EDR connection example
└── .../              # More examples coming soon
```

### 3.3 Import and Run

1. Open **Xcode**
2. Click **File → Open**, select corresponding example directory (e.g., `UsingCoreBluetoothClassic/`)
3. Wait for project loading to complete
4. Connect iOS device or select simulator, click **Product → Run**
5. Open APP on device, test Bluetooth functionality

---

## 4. Project Structure

```
iOS-BT-Demo/
├── UsingCoreBluetoothClassic/                          # 📌 ATT device connection example
├── LICENSE.txt                              # Apache 2.0 open source license
└── README.md
```



* [UsingCoreBluetoothClassic](https://github.com/Jieli-Tech/ios-bt-demo/tree/main/UsingCoreBluetoothClassic) --- GATT Over BR/EDR connection example



---

## 5. Example Selection Guide

### 5.1 GATT Over BR/EDR Connection Example (`UsingCoreBluetoothClassic/`)

| Item | Description |
|------|------|
| **Applicable Scenarios** | Bluetooth devices (Classic Bluetooth), requiring high-speed data communication via GATT protocol |
| **Key Features** | GATT over BR/EDR connection/disconnection management, data send/receive, GATT service discovery |
| **Core Classes** | `CBCentralManager` (Bluetooth scanning), `CBPeripheral` (Peripheral management) |
| **Reference Documentation** | [UsingCoreBluetoothClassic Details](UsingCoreBluetoothClassic/README.md) |




---

## 6. Community and Support

### Technical Exchange

| Platform | Group/Link | Status |
|------|-----------|------|
| **GitHub** | [Jieli-Tech](https://github.com/Jieli-Tech) | ✅ Active |
| **Issue Feedback** | [Submit Issue](https://github.com/Jieli-Tech/ios-bt-demo/issues) | ✅ Open |

### Resource Links

| Resource | Link |
|------|------|
| 📖 **Online Documentation** | [https://doc.zh-jieli.com/vue](https://doc.zh-jieli.com/vue/#/home) |
| 🐛 **Issue Feedback** | [GitHub Issues](https://github.com/Jieli-Tech/ios-bt-demo/issues) |

---



## 7. Version History

| Version  | Date       | Changes           |
| ----- | ---------- | ------------------ |
| 1.0.0 | 2025/03/32 | 1. Added UsingCoreBluetoothClassic connection example |



## 8. License

This project is licensed under [Apache License 2.0](./LICENSE) open source protocol.

```
Copyright 2025 Jieli Technology Co., Ltd. (Zhuhai)

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


   **© 2025 Jieli Technology Co., Ltd. (Zhuhai) | Licensed under Apache License 2.0**

</div>