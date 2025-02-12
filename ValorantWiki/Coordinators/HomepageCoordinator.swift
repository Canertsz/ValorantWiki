//
//  MainCoordinator.swift
//  ValorantWiki
//
//  Created by Caner Tüysüz on 20.12.2024.
//

import Foundation
import UIKit

class HomepageCoordinator: BaseCoordinator {
    
    private let navigationController: UINavigationController
    var viewModel: HomepageViewModelProtocol
    
    init(navigationController: UINavigationController, viewModel: HomepageViewModelProtocol) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    override func start() {
        viewModel.coordinator = self
        let viewController = HomepageVC.instantiateViewController()
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func navigateToDetails() {
        
    }
}
