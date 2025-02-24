//
//  BaseCoordinator.swift
//  ValorantWiki
//
//  Created by Caner Tüysüz on 7.01.2025.
//
import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController? { get set }
    func start()
}
