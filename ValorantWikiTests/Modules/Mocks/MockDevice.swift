//
//  MockDevice.swift
//  ValorantWiki
//
//  Created by Caner Tüysüz on 8.03.2025.
//

@testable import ValorantWiki

final class MockDevice: DeviceProtocol {
    var stubbedWidth: Double!
    var invokedScreenWidth: Bool = false
    var screenWidth: Double {
        get {
            invokedScreenWidth = true
            return stubbedWidth
        }
        set { stubbedWidth = newValue }
    }
    
    var stubbedHeight: Double!
    var invokedScreenHeight: Bool = false
    var screenHeight: Double {
        get {
            invokedScreenHeight = true
            return stubbedHeight
        }
        set {
            stubbedHeight = newValue
        }
    }
}
