//
//  HomepageViewModel.swift
//  ValorantWiki
//
//  Created by Caner Tüysüz on 20.12.2024.
//

import Foundation

protocol HomepageViewModelProtocol {
    func viewDidLoad()
    var delegate: HomepageViewModelDelegate? { get set }
    var agents: [Agent]? { get }
    var coordinator: HomepageCoordinator? { get set }
}

protocol HomepageViewModelDelegate: AnyObject {
    func didFetchAgents()
}

final class HomepageViewModel: HomepageViewModelProtocol {
    var agents: [Agent]? = []
    
    weak var delegate: HomepageViewModelDelegate?
    weak var coordinator: HomepageCoordinator?
    private let repository: HomepageRepositoryProtocol
    
    init(repository: HomepageRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchCharacters() {
        repository.fetchAgents { response in
            switch response {
            case .success(let agentResponse):
                self.agents = agentResponse.data
                self.delegate?.didFetchAgents()
                print(self.agents)
            case .failure(let error):
                print("Failed to fetch Characters: \(error)")
            }
        }
    }
    
    func viewDidLoad() {
        fetchCharacters()
    }
}
