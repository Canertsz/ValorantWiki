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
    func sizeForItemAt() -> CGSize
    func searchAgents(with searchText: String)
}

private extension HomepageViewModel {
    enum Constant {
        static let cellWidthRatio = 2.3
        static let cellHeight = 250.0
    }
}

final class HomepageViewModel {
    private weak var view: HomepageViewProtocol?
    private let coordinator: HomepageCoordinatorProtocol
    private let repository: HomepageRepositoryProtocol
    private let device: DeviceProtocol
    
    private var agents: [Agent] = []
    private var filteredAgents: [Agent] = []
    
    private var listingAgents: [Agent] {
        filteredAgents.isEmpty ? agents : filteredAgents
    }
    
    init(
        view: HomepageViewProtocol,
        repository: HomepageRepositoryProtocol,
        coordinator: HomepageCoordinatorProtocol,
        device: DeviceProtocol = Device.shared
    ) {
        self.view = view
        self.repository = repository
        self.coordinator = coordinator
        self.device = device
    }
}

// MARK: - HomepageViewModelProtocol
extension HomepageViewModel: HomepageViewModelProtocol {
    var numberOfItemsInSection: Int { listingAgents.count }
    
    func viewDidLoad() {
        view?.setupUI()
        repository.fetchAgents()
    }
    
    func agent(for indexPath: IndexPath) -> Agent? { listingAgents[safe: indexPath.row] }
    
    func didTapAgentCellDetailButton(agent: Agent) {
        coordinator.navigateToAgentDetail(agent: agent)
    }
    
    func sizeForItemAt() -> CGSize {
        let width = device.screenWidth / Constant.cellWidthRatio
        return CGSize(
            width: width,
            height: Constant.cellHeight
        )
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
