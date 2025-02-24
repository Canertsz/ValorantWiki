//
//  HomepageViewModel.swift
//  ValorantWiki
//
//  Created by Caner Tüysüz on 20.12.2024.
//

import Foundation

protocol HomepageViewModelProtocol: AgentCellViewModelDelegate {
    var numberOfItemsInSection: Int { get }
    func viewDidLoad()
    func filteringAgents()
    func agent(for indexPath: IndexPath) -> Agent?
    func searchAgents(with searchText: String)
}

final class HomepageViewModel {
    private weak var view: HomepageViewProtocol?
    private let coordinator: HomepageCoordinatorProtocol
    private let repository: HomepageRepositoryProtocol
    
    private var agents: [Agent] = []
    private var filteredAgents: [Agent] = []
    
    private var listingAgents: [Agent] {
        filteredAgents.isEmpty ? agents : filteredAgents
    }
    
    init(view: HomepageViewProtocol,
         repository: HomepageRepositoryProtocol,
         coordinator: HomepageCoordinatorProtocol) {
        self.view = view
        self.repository = repository
        self.coordinator = coordinator
    }
        
    func viewDidLoad() {
        view?.setupUI()
        repository.fetchAgents()
    }
}

extension HomepageViewModel: HomepageViewModelProtocol {
    var numberOfItemsInSection: Int { listingAgents.count }
    
    func agent(for indexPath: IndexPath) -> Agent? { listingAgents[safe: indexPath.row] }
    
    func didTapAgentCellDetailButton(agent: Agent) {
        coordinator.navigateToAgentDetail(agent: agent)
    }
    
    // MARK: - Search
    func searchAgents(with searchText: String) {
        if searchText.isEmpty {
            filteredAgents = agents
        } else {
            filteredAgents = agents.filter { $0.displayName!.lowercased().starts(with: searchText.lowercased()) }
        }
    }
    
    func filteringAgents() {
        view?.reloadCollectionView()
    }
}

extension HomepageViewModel: HomepageRepositoryDelegate {
    func didFetchAgents(_ result: NetworkResult<AgentResponse>) {
        switch result {
        case .success(let agentResponse):
            agents = agentResponse.data ?? []
            filteredAgents = agents
            view?.reloadCollectionView()
            // print(self.agents)
        case .failure(let error):
            print("Failed to fetch Characters: \(error)")
        }
    }
}
