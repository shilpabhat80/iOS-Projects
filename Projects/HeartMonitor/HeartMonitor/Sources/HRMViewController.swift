//
//  HRMViewController.swift
//  HeartMonitor
//
//  Created by Shilpa Bhat on 23/4/17.
//

import UIKit
import CoreBluetooth
import QuartzCore

let POLARH7_HRM_DEVICE_INFO_SERVICE_UUID = "180A"
let POLARH7_HRM_HEART_RATE_SERVICE_UUID = "180D"
let POLARH7_HRM_MEASUREMENT_CHARACTERISTIC_UUID = "2A37"
let POLARH7_HRM_BODY_LOCATION_CHARACTERISTIC_UUID = "2A38"
let POLARH7_HRM_MANUFACTURER_NAME_CHARACTERISTIC_UUID = "2A29"


class HRMViewController: UIViewController {
    
    @IBOutlet weak var heartImage: UIImageView!
    @IBOutlet weak var deviceInfo: UITextView!
    
    var centralManager = CBCentralManager()
    var polarH7HRMPeripheral:CBPeripheral?
    
    var polarH7DeviceData:String?
    var heartRateBPM:UILabel?
    var connected  = ""
    var bodyData = ""
    var manufacturer = ""
    var heartRate:Double = 0
    var pulseTimer:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.groupTableViewBackground
        self.heartImage.image = UIImage(named: "HeartImage")
        
        // Clear out textView
        deviceInfo.text = ""
        deviceInfo.textColor = UIColor.blue
        deviceInfo.backgroundColor = UIColor.groupTableViewBackground
        deviceInfo.isUserInteractionEnabled = false
        
        // Create your Heart Rate BPM Label
        heartRateBPM = UILabel(frame: CGRect(x:55, y:30, width:self.heartImage.bounds.size.width, height:50))
        heartRateBPM?.text = "0"
        heartRateBPM?.textColor = UIColor.white
        heartRateBPM?.textAlignment = .center;
        heartImage.addSubview(heartRateBPM!)
        
        // Scan for all available CoreBluetooth LE devices
        let services = [CBUUID(string:POLARH7_HRM_HEART_RATE_SERVICE_UUID),
                        CBUUID(string:POLARH7_HRM_DEVICE_INFO_SERVICE_UUID)]
        centralManager.delegate = self
        centralManager.scanForPeripherals(withServices: services, options: [:])
        
        updateHeartRateTo(bpm:72.0)
    }
    
}

extension HRMViewController: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch(central.state) {
        case .poweredOff:
            print("CoreBluetooth BLE hardware is powered off")
        case .poweredOn:
            print("CoreBluetooth BLE hardware is powered on and ready")
        case .unauthorized:
            print("CoreBluetooth BLE state is unauthorized")
        case .unknown:
            print("CoreBluetooth BLE state is unknown")
        case .unsupported:
            print("CoreBluetooth BLE hardware is unsupported on this platform")
        default:
            break
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        let localName = advertisementData[CBAdvertisementDataLocalNameKey] as! String
        if localName.characters.count > 0 {
            print("Found the heart rate monitor: \(localName)")
            centralManager.stopScan()
            polarH7HRMPeripheral = peripheral
            peripheral.delegate = self
            centralManager.connect(peripheral, options: [:])
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self
        peripheral.discoverServices([])
        
        let connectedValue = peripheral.state == .connected ? "YES" : "NO"
        connected = "Connected: \(connectedValue)"
        print(connected)
    }
    
}

extension HRMViewController: CBPeripheralDelegate {
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        for service in peripheral.services! {
            print("Discovered service \(service.uuid)")
            peripheral.discoverCharacteristics([], for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
        
        if service.uuid.description == POLARH7_HRM_HEART_RATE_SERVICE_UUID  {  // 1
            for aChar in service.characteristics!
            {
                // Request heart rate notifications
                if aChar.uuid == CBUUID(string:POLARH7_HRM_MEASUREMENT_CHARACTERISTIC_UUID) { // 2
                    polarH7HRMPeripheral?.setNotifyValue(true, for: aChar)
                    print("Found heart rate measurement characteristic");
                }
                    // Request body sensor location
                else if aChar.uuid == CBUUID(string:POLARH7_HRM_BODY_LOCATION_CHARACTERISTIC_UUID) { // 3
                    polarH7HRMPeripheral?.readValue(for: aChar)
                    print("Found body sensor location characteristic");
                }
            }
        }
        // Retrieve Device Information Services for the Manufacturer Name
        if service.uuid == CBUUID(string:POLARH7_HRM_DEVICE_INFO_SERVICE_UUID) { // 4
            for aChar in service.characteristics!
            {
                if aChar.uuid == CBUUID(string:POLARH7_HRM_MANUFACTURER_NAME_CHARACTERISTIC_UUID) {
                    polarH7HRMPeripheral?.readValue(for: aChar)
                    print("Found a device manufacturer name characteristic");
                }
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
        // Updated value for heart rate measurement received
        if characteristic.uuid == CBUUID(string:POLARH7_HRM_MEASUREMENT_CHARACTERISTIC_UUID)  {  // 1
            // Get the Heart Rate Monitor BPM
            getHeartBPMData(characteristic, error:error)
        }
            // Retrieve the characteristic value for manufacturer name received
        else if characteristic.uuid == CBUUID(string:POLARH7_HRM_MANUFACTURER_NAME_CHARACTERISTIC_UUID)  {  // 2
            getManufacturerName(characteristic)
        }
            // Retrieve the characteristic value for the body sensor location received
        else if characteristic.uuid == CBUUID(string:POLARH7_HRM_BODY_LOCATION_CHARACTERISTIC_UUID)  {  // 3
            getBodyLocation(characteristic)
        }
        
        // Add your constructed device information to your UITextView
        self.deviceInfo.text = "\(self.connected)\n\(self.bodyData)\n\(self.manufacturer)"
    }
}

extension HRMViewController {
    
    // Instance method to get the heart rate BPM information
    func getHeartBPMData(_ characteristic:CBCharacteristic, error:Error?)
    {
        // Get the Heart Rate Monitor BPM
        guard let data = characteristic.value else {
            return
        }
        
        var bytes = Array(repeating: 0 as UInt8, count:data.count/MemoryLayout<UInt8>.size)
        data.copyBytes(to: &bytes, count:data.count)
        
        let bpm = bytes[1]
        
        
        // Display the heart rate value to the UI if no error occurred
        updateHeartRateTo(bpm:Double(bpm))
        
    }
    
    // Instance method to get the body location of the device
    func getBodyLocation(_ characteristic:CBCharacteristic) {
        guard let data = characteristic.value else {
            return
        }
        var bytes = Array(repeating: 0 as UInt8, count:data.count/MemoryLayout<UInt8>.size)
        data.copyBytes(to: &bytes, count:data.count)

        
        if bytes.count > 0 {
            let bodyLocation = bytes[0];  // 2
            self.bodyData = "Body Location: \(bodyLocation == 1 ? "Chest" : "Undefined")" // 3
        }
        else {  // 4
            self.bodyData = "Body Location: N/A"
        }
        return;
    }

    func updateHeartRateTo(bpm: Double)
    {
        self.heartRate = bpm;
        heartRateBPM?.text = "\(bpm) bpm";
        doHeartBeat()
        pulseTimer = Timer.scheduledTimer(timeInterval: Double(60 / self.heartRate), target: self, selector: #selector(doHeartBeat), userInfo: nil, repeats: false)
    }
    
    // Instance method to get the manufacturer name of the device
    func getManufacturerName(_ characteristic:CBCharacteristic) {
        self.manufacturer = ""
        
        guard let data = characteristic.value else {
            return
        }
        if let manufacturerName = String(data: data, encoding: String.Encoding.utf8) {
            self.manufacturer = "Manufacturer: \(manufacturerName)"    // 2
        }
    }
    
    // Helper method to perform a heartbeat animation
    func doHeartBeat()
    {
        let layer = self.heartImage.layer;
        
        let pulseAnimation = CABasicAnimation(keyPath:"transform.scale")
        pulseAnimation.toValue = 1.1
        pulseAnimation.fromValue = 1.0
        pulseAnimation.duration = Double(60.0 / heartRate / 2.0)
        pulseAnimation.repeatCount = 1
        pulseAnimation.autoreverses = true
        pulseAnimation.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseIn)
        layer.add(pulseAnimation, forKey: "scale")
        
        self.pulseTimer = Timer.scheduledTimer(timeInterval: 60.0 / self.heartRate, target: self, selector: #selector(doHeartBeat), userInfo: nil, repeats: false)
    }
}
