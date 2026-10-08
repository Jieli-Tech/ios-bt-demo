# CBClassic

<div align="center">

**基于 CoreBluetooth 框架的 GATT over BR/EDR 设备连接示例，演示如何在 iOS 端通过 GATT 协议与蓝牙设备进行数据通讯。**

[中文](./README.md) · [English](./README_en.md) · [文档中心](https://doc.zh-jieli.com/Apps/iOS/ota/zh-cn/master/Development/Content/gatt_over_edr_desc.html#gatt-over-edr) · [版本历史](#十版本历史) · [报告问题](https://github.com/Jieli-Tech/ios-bt-demo/issues)

</div>

---

## 📋 目录

- [一、概述](#一概述)
- [二、支持的平台与设备](#二支持的平台与设备)
- [三、快速开始](#三快速开始)
- [四、工程结构](#四工程结构)
- [五、使用指南](#五使用指南)
- [六、配置说明](#六配置说明)
- [七、调试说明](#七调试说明)
- [八、注意事项](#八注意事项)
- [九、社区与支持](#九社区与支持)
- [十、版本历史](#十版本历史)
- [十一、许可证](#十一许可证)

---

## 一、概述

`CBClassic` 是珠海杰理科技股份有限公司提供的 iOS 端 GATT Over BR/EDR 连接示例工程。

在 iOS 开发中，CoreBluetooth 框架允许应用程序与支持蓝牙低能耗（BLE）的设备进行通信。其中 GATT 通讯又分为 **GATT over BLE** 和 **GATT over BR/EDR** 两种：

| 协议类型 | 底层协议 | 特点 |
|---------|---------|------|
| **GATT over BR/EDR** | BR/EDR 底层协议 | 更高效，传输速率更高，数据量更大 |

本示例基于 Apple 官方示例 [Using Core Bluetooth Classic](https://developer.apple.com/documentation/corebluetooth/using-core-bluetooth-classic)，演示了 GATT over BR/EDR 设备的连接事件监听、连接/断开管理、服务发现以及数据收发等功能。

> **核心 API**：使用 `CBCentralManagerDelegate` 中的 `registerForConnectionEvents(options:)` 方法和代理方法 `centralManager(_:connectionEventDidOccur:for:)` 来监听蓝牙设备的 GATT over BR/EDR 连接事件。

---

## 二、支持的平台与设备

### 2.1 iOS 系统要求

| 项目 | 说明 |
|------|------|
| **最低版本** | iOS 13.0 |
| **目标版本** | iOS 13.0+ |
| **开发语言** | Swift |
| **开发环境** | Xcode 14.0+ |

### 2.2 支持的蓝牙协议

| 协议 | 说明 | 状态 |
|------|------|------|
| GATT over BR/EDR | 基于经典蓝牙的 GATT 通讯，速率更高 | ✅ 支持 |



> **注意**：`registerForConnectionEvents` 方法在 iOS 13.0 及以上版本可用。

---

## 三、快速开始

### 3.1 克隆仓库

```bash
git clone https://github.com/Jieli-Tech/ios-bt-demo.git
cd ios-bt-demo/UsingCoreBluetoothClassic
```

### 3.2 导入工程

1. 打开 **Xcode**
2. 点击 **File → Open**，选择 `CoreBluetoothClassicSample.xcodeproj`
3. 选择目标设备或模拟器
4. 点击 **Run（▶）** 编译并运行

### 3.3 权限配置

在 `Info.plist` 中已配置蓝牙使用权限：

```xml
<key>NSBluetoothAlwaysUsageDescription</key>
<string>Use bluetooth to discover, connect to, and share information with nearby devices</string>
```

如需后台蓝牙支持，还需配置后台模式：

```xml
<key>UIBackgroundModes</key>
<array>
    <string>bluetooth-central</string>
</array>
```

---

## 四、工程结构

```
UsingCoreBluetoothClassic/
├── CoreBluetoothClassicSample.xcodeproj/      # Xcode 工程文件
├── CoreBluetoothClassicSample/                # 应用主模块
│   ├── AppDelegate.swift                      #   应用代理
│   ├── CentralViewController.swift            #   中心设备控制器（扫描与连接）
│   ├── PeripheralViewController.swift         #   外设交互控制器（数据收发）
│   ├── Assets.xcassets/                       #   资源文件
│   ├── Base.lproj/                            #   Storyboard 文件
│   └── Info.plist                             #   应用配置（权限等）
├── Configuration/                             # 构建配置
│   └── SampleCode.xcconfig
└── LICENSE                                    # Apache 2.0 开源协议
```

### 4.1 核心类说明

| 类 | 路径 | 说明 |
|------|------|------|
| `CentralViewController` | `CoreBluetoothClassicSample/CentralViewController.swift` | 中心设备控制器，负责 CBCentralManager 初始化和 GATT Over BR/EDR 设备连接事件监听 |
| `PeripheralViewController` | `CoreBluetoothClassicSample/PeripheralViewController.swift` | 外设交互控制器，负责服务发现、特征读写与数据收发 |
| `BTConstants` | `CentralViewController.swift` 内部定义 | 全局 UUID 常量，包含服务 UUID 和读写特征 UUID |

---

## 五、使用指南

### 5.1 权限申请

从 iOS 13 开始，访问蓝牙需要用户的明确同意。在 `Info.plist` 中必须声明 `NSBluetoothAlwaysUsageDescription`：

```xml
<key>NSBluetoothAlwaysUsageDescription</key>
<string>Use bluetooth to discover, connect to, and share information with nearby devices</string>
```

### 5.2 GATT over BR/EDR 设备的连接事件监听

使用 `registerForConnectionEvents(options:)` 注册 GATT over BR/EDR 连接事件监听：

```swift
// 初始化 CBCentralManager
cbManager = CBCentralManager(delegate: self, queue: nil)

// 在 centralManagerDidUpdateState(_:) 中检查蓝牙状态
func centralManagerDidUpdateState(_ central: CBCentralManager) {
    switch central.state {
    case .poweredOn:
        os_log("启动 cbManager")
        let matchingOptions = [
            CBConnectionEventMatchingOption.serviceUUIDs: [BTConstants.sampleServiceUUID]
        ]
        cbManager.registerForConnectionEvents(options: matchingOptions)
    case .poweredOff:
        os_log("蓝牙当前处于关闭状态")
    default:
        break
    }
}
```

注册后，当有 GATT over BR/EDR 设备连接或断开时，系统会回调以下代理方法：

```swift
func centralManager(_ central: CBCentralManager,
                    connectionEventDidOccur event: CBConnectionEvent,
                    for peripheral: CBPeripheral) {
    switch event {
    case .peerConnected:
        os_log("peerConnected for peripheral: %@", peripheral)
        cbPeripherals.append(peripheral)
    case .peerDisconnected:
        os_log("peerDisconnected for peripheral: %@", peripheral)
        if let idx = cbPeripherals.firstIndex(where: { $0 === peripheral }) {
            cbPeripherals.remove(at: idx)
        }
    @unknown default:
        fatalError("Unhandled event type")
    }
    tableView.reloadData()
}
```

### 5.3 连接设备并发现服务

用户点击设备列表中的设备后，调用 `connect(_:options:)` 建立连接，连接成功后跳转至 `PeripheralViewController` 进行服务发现：

```swift
// CentralViewController 中处理连接
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let peripheral = cbPeripherals[indexPath.row]
    cbManager.connect(peripheral, options: nil)
}

func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
    os_log("peripheral: %@ connected", peripheral)
    let peripheralVC = PeripheralViewController()
    peripheralVC.cbManager = cbManager
    peripheralVC.selectedPeripheral = peripheral
    present(peripheralVC, animated: true, completion: nil)
}
```

在 `PeripheralViewController` 中，设置代理并发起服务发现：

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    selectedPeripheral.delegate = self
    selectedPeripheral.discoverServices([BTConstants.sampleServiceUUID])
}
```

### 5.4 发送数据

通过写特征（Write Characteristic）向设备发送数据：

```swift
@objc private func sendData() {
    guard let characteristic = writeCharacteristic else {
        os_log("Write characteristic not found")
        return
    }
    guard let text = inputTextField.text, !text.isEmpty else { return }

    let dataToSend = text.data(using: .utf8)!
    selectedPeripheral.writeValue(dataToSend, for: characteristic, type: .withResponse)
    os_log("Sent data: %@", text)
}
```

### 5.5 接收数据

订阅通知特征（Notify Characteristic）后，设备推送的数据通过代理方法回调：

```swift
// 订阅通知
peripheral.setNotifyValue(true, for: characteristic)

// 接收数据回调
func peripheral(_ peripheral: CBPeripheral,
                didUpdateValueFor characteristic: CBCharacteristic,
                error: Error?) {
    if characteristic.uuid == BTConstants.readCharacteristicUUID,
       let value = characteristic.value {
        let receivedText = String(data: value, encoding: .utf8) ?? "Invalid Data"
        os_log("Received data: %@", receivedText)
        DispatchQueue.main.async {
            self.receivedDataLabel.text = "接收数据：\(receivedText)"
        }
    }
}
```

---

## 六、配置说明

UUID 配置常量定义在 `CentralViewController.swift` 的 `BTConstants` 结构体中：

```swift
struct BTConstants {
    static let sampleServiceUUID = CBUUID(string: "AE00")          // 服务 UUID
    static let writeCharacteristicUUID = CBUUID(string: "AE01")    // 写特征 UUID
    static let readCharacteristicUUID = CBUUID(string: "AE02")     // 读/通知特征 UUID
}
```

> **💡 提示**：请根据实际设备端的 UUID 配置修改上述常量，确保 APP 端与设备端的 UUID 一致。

---

## 七、调试说明

### 7.1 日志输出

工程使用 `os_log` 进行日志输出，可在 Xcode Console 中查看运行日志：

```swift
import os.log

os_log("启动 cbManager")
os_log("peerConnected for peripheral: %@", peripheral)
os_log("Received data: %@", receivedText)
```

### 7.2 Console 过滤

在 Xcode Console 的搜索框中输入关键词（如 `peripheral`、`Received`、`Error`）可快速过滤相关日志。

### 7.3 常见问题排查

| 问题 | 可能原因 | 排查方法 |
|------|---------|---------|
| 设备扫描不到 | 蓝牙未开启 / 权限未授予 | 检查系统蓝牙开关和 APP 权限设置 |
| 连接失败 | 设备未配对 / UUID 不匹配 | 确认设备已配对且 UUID 配置正确 |
| 数据收发失败 | 特征未发现 / 未订阅通知 | 检查 `didDiscoverCharacteristicsFor` 回调日志 |

---

## 八、注意事项

1. **iOS 版本要求**：`registerForConnectionEvents` 方法需要 iOS 13.0 及以上版本。
2. **性能影响**：频繁地接收连接事件可能会影响应用性能，建议谨慎选择监听哪些设备的连接事件。
3. **后台模式**：如果需要在后台处理蓝牙连接事件，请在 Info.plist 中配置 `bluetooth-central` 后台模式。
4. **GATT Over BR/EDR 设备要求**：
   - 连接之前需确保设备**已配对**（BR/EDR 底层协议要求）
   - iOS 端 GATT Over BR/EDR 功能支持可能存在兼容性差异，建议在目标设备上充分测试。
5. **模拟器限制**：蓝牙功能无法在 iOS 模拟器上使用，请使用真机测试。

> Note: 本示例代码关联 WWDC 2019 session [901: What's New in Core Bluetooth](https://developer.apple.com/videos/play/wwdc19/901/)。

---

## 九、社区与支持
### 技术交流

| 平台 | 群号/链接 | 状态 |
|------|-----------|------|
| **Gitee** | [JieLi-Tech](https://github.com/Jieli-Tech) | ✅ 活跃 |
| **问题反馈** | [提交 Issue](https://github.com/Jieli-Tech/ios-bt-demo/issues) | ✅ 开放 |

### 资源链接

| 资源 | 链接 |
|------|------|
| 📖 **在线文档中心** | [https://doc.zh-jieli.com/vue](https://doc.zh-jieli.com/vue/#/home) |
| 🐛 **问题反馈** | [Gitee Issues](https://github.com/Jieli-Tech/ios-bt-demo/issues) |

---

## 十、版本历史

| 版本  | 日期       | 修改记录                                  |
| ----- | ---------- | ----------------------------------------- |
| 1.0.0 | 2025/03/31 | 1. 初始化版本<br />2. 增加 GATT over BR/EDR 设备连接事件监听示例<br />3. 增加数据收发功能 |

---

## 十一、许可证

本项目采用 [Apache License 2.0](./LICENSE) 开源协议。

```
Copyright 2024 珠海市杰理科技股份有限公司

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

   **© 2024 珠海市杰理科技股份有限公司 | Licensed under Apache License 2.0**

</div>
