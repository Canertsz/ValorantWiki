//
//  MockHomepageVC.swift
//  ValorantWikiTests
//
//  Created by Caner Tüysüz on 14.02.2025.
//

import Foundation
@testable import ValorantWiki

final class MockHomepageVC: HomepageViewProtocol {
    
    var setupUICallCount = 0
    func setupUI() {
        setupUICallCount += 1
    }
    
    var reloadCollectionViewCallCount = 0
    func reloadCollectionView() {
        reloadCollectionViewCallCount += 1
    }
}
