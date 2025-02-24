//
//  MockHomepageCoordinator.swift
//  ValorantWikiTests
//
//  Created by Caner Tüysüz on 14.02.2025.
//

import Foundation
import UIKit
@testable import ValorantWiki

final class MockHomepageCoordinator: HomepageCoordinatorProtocol {
    var navigationController: UINavigationController?
    var didNavigateToAgentDetails: Bool = false
    var navigatedAgent: Agent?
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    func navigateToAgentDetail(agent: ValorantWiki.Agent) {
        didNavigateToAgentDetails = true
        navigatedAgent = agent
    }
    
    func start() {
        
    }
    
    
}
