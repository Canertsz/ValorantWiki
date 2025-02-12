//
//  BaseCoordinator.swift
//  ValorantWiki
//
//  Created by Caner Tüysüz on 7.01.2025.
//

protocol Coordinator {
    func start()
}

class BaseCoordinator: Coordinator {
    func start() {
        fatalError("Start method must be implemented.")
    }
}
