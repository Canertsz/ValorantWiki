//
//  MainCoordinator.swift
//  ValorantWiki
//
//  Created by Caner Tüysüz on 20.12.2024.
//

import Foundation
import UIKit

protocol HomepageCoordinatorProtocol: Coordinator {
    func navigateToAgentDetail(agent: Agent)
}

final class HomepageCoordinator: HomepageCoordinatorProtocol {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = HomepageVC.instantiateViewController()
        let repository = HomepageRepository()
        let viewModel = HomepageViewModel(view: viewController,
                                          repository: repository,
                                          coordinator: self)
        repository.delegate = viewModel
        viewController.viewModel = viewModel
        
        navigationController?.pushViewController(viewController,
                                                 animated: true)
    }
    
    func navigateToAgentDetail(agent: Agent) {
        let viewController = AgentDetailVC.instantiateViewController()
        let viewModel = AgentDetailViewModel(agent: agent)
        viewController.viewModel = viewModel
        
        viewController.modalPresentationStyle = .fullScreen
        viewController.hero.isEnabled = true
        navigationController?.hero.isEnabled = true
        
        navigationController?.pushViewController(viewController,
                                                 animated: true)
    }
}
