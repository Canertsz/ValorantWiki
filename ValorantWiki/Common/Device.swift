//
//  Device.swift
//  ValorantWiki
//
//  Created by Caner Tüysüz on 12.03.2025.
//

import UIKit

protocol DeviceProtocol {
    var screenWidth: Double { get }
    var screenHeight: Double { get }
}

final class Device {
    static let shared: DeviceProtocol = Device()
}

extension Device: DeviceProtocol {
    private var deviceSize: CGRect { UIScreen.main.bounds }
    var screenWidth: Double { deviceSize.width }
    var screenHeight: Double { deviceSize.height }
}
