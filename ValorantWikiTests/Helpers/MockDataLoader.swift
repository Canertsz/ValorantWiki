//
//  MockDataLoader.swift
//  ValorantWiki
//
//  Created by Caner Tüysüz on 14.02.2025.
//

import Foundation

@propertyWrapper
struct MockData<T: Decodable> {
    private let resourceName: String
    private let bundle: Bundle
    
    init(resourceName: String, bundle: Bundle = .main) {
        self.resourceName = resourceName
        self.bundle = bundle
    }
    
    var wrappedValue: T? {
        Self.loadResource(named: resourceName, bundle: Bundle(for: HomePageViewModelTests.self))
    }
    
    private static func loadResource(named name: String, bundle: Bundle) -> T? {
        guard let url = bundle.url(forResource: name, withExtension: nil) else {
            print("⚠️ MockData: Could not find resource \(name)")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
        } catch {
            print("⚠️ MockData: Failed to decode \(name) - \(error)")
            return nil
        }
    }
}
