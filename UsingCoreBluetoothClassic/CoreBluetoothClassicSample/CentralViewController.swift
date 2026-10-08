import CoreBluetooth
import UIKit
import os.log

struct BTConstants {
    static let sampleServiceUUID = CBUUID(string: "AE00")
    static let writeCharacteristicUUID = CBUUID(string: "AE01") // 用于写入数据
    static let readCharacteristicUUID = CBUUID(string: "AE02")  // 读取和通知数据
}

class CentralViewController: UIViewController {
    private var tipsLab: UILabel!
    private var listHintLab: UILabel!
    private var tableView: UITableView!
    private var cbManager: CBCentralManager!
    private var cbState = CBManagerState.unknown
    private var cbPeripherals = [CBPeripheral]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置 View Controller 的标题
        title = "Peripherals"
        // MARK: - 顶部提示
        tipsLab = UILabel()
        tipsLab.numberOfLines = 0
        tipsLab.text = "GATT over BR/EDR 要求用户先在系统蓝牙设置中完成经典蓝牙设备配对与连接。只有在连接建立之后，该设备才会出现在此设备列表中。当前默认的可发现特征（Discoverable Characteristic）为 AE00；若该特征值不正确，设备将无法被发现。\nFor GATT over BR/EDR, the user must first complete Classic Bluetooth pairing and connection via the system Bluetooth settings. The device will only be discovered in this list after the connection is established. The current default discoverable characteristic is AE00. If this value is incorrect, the device cannot be discovered."
        tipsLab.translatesAutoresizingMaskIntoConstraints = false

        // 圆角 + 描边
        tipsLab.layer.cornerRadius = 8
        tipsLab.layer.borderWidth = 1.0
        tipsLab.layer.borderColor = UIColor.systemGray4.resolvedColor(with: traitCollection).cgColor
        tipsLab.clipsToBounds = true

        view.addSubview(tipsLab)

        // MARK: - 下方说明：提示用户 tableview 才是发现的设备
        listHintLab = UILabel()
        listHintLab.numberOfLines = 0
        listHintLab.text = "下方列表展示的是已发现的设备。\nThe list below shows the discovered devices."
        listHintLab.font = .systemFont(ofSize: 13)
        listHintLab.textColor = .secondaryLabel
        listHintLab.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(listHintLab)

        // MARK: - tableView
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "peripheralCell")
        view.addSubview(tableView)

        // MARK: - 约束
        NSLayoutConstraint.activate([
            // tipsLab
            tipsLab.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            tipsLab.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tipsLab.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            // listHintLab：紧贴 tipsLab 下方
            listHintLab.topAnchor.constraint(equalTo: tipsLab.bottomAnchor, constant: 8),
            listHintLab.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            listHintLab.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            // tableView：接在 listHintLab 底部
            tableView.topAnchor.constraint(equalTo: listHintLab.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // 3. 初始化 CBCentralManager
        cbManager = CBCentralManager(delegate: self, queue: nil)
    }
}




extension CentralViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cbPeripherals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "peripheralCell", for: indexPath)
        let index = cbPeripherals.count - (indexPath.row + 1)
        cell.textLabel?.text = "\(cbPeripherals[index].name ?? "CBPeripheral")"
        return cell
    }
}

extension CentralViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let peripheral = cbPeripherals[indexPath.row]
        cbManager.connect(peripheral, options: nil)
    }
}

extension CentralViewController: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        // 在应用程序中，你需要处理每种 central.state 和 central.authorization 的可能值
        switch central.state {
        case .resetting:
            os_log("与系统服务的连接暂时丢失，即将更新")
        case .unsupported:
            os_log("平台不支持蓝牙低能耗中心/客户端角色")
        case .unauthorized:
            switch central.authorization {
            case .restricted:
                os_log("此设备的蓝牙被限制使用")
            case .denied:
                os_log("该应用没有授权使用蓝牙低能耗角色")
            default:
                os_log("发生了未知错误，正在清理 cbManager")
            }
        case .poweredOff:
            os_log("蓝牙当前处于关闭状态")
        case .poweredOn:
            os_log("启动 cbManager")
            let matchingOptions = [CBConnectionEventMatchingOption.serviceUUIDs: [BTConstants.sampleServiceUUID]]
            cbManager.registerForConnectionEvents(options: matchingOptions)
        default:
            os_log("清理 cbManager")
        }
    }
    
    func centralManager(_ central: CBCentralManager, connectionEventDidOccur event: CBConnectionEvent, for peripheral: CBPeripheral) {
        switch event {
        case .peerConnected:
            os_log("peerConnected for peripheral: %@", peripheral)
            cbPeripherals.append(peripheral)
        case .peerDisconnected:
            os_log("peerDisconnected for peripheral:%@", peripheral)
        default:
            if let idx = cbPeripherals.firstIndex(where: { $0 === peripheral }) {
                cbPeripherals.remove(at: idx)
            }
        }
        tableView.reloadData()
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        os_log("peripheral: %@ connected", peripheral)
        let peripheralVC = PeripheralViewController()
        peripheralVC.cbManager = cbManager
        peripheralVC.selectedPeripheral = peripheral
        present(peripheralVC, animated: true, completion: nil)
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        os_log("peripheral: %@ failed to connect", peripheral)
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        os_log("peripheral: %@ disconnected", peripheral)
    }
}
