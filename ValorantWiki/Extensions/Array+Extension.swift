//
//  Array+Extension.swift
//  ValorantWiki
//
//  Created by Caner Tüysüz on 14.02.2025.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
