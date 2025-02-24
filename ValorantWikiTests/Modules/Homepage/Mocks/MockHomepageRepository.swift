//
//  MockHomepageRepository.swift
//  ValorantWikiTests
//
//  Created by Caner Tüysüz on 14.02.2025.
//

import Foundation
@testable import ValorantWiki

final class MockHomepageRepository: HomepageRepositoryProtocol {
    var fetchAgentsCallCount = 0
    func fetchAgents() {
        fetchAgentsCallCount += 1
    }
    
}
