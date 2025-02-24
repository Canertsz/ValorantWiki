//
//  HomepageRepository.swift
//  ValorantWiki
//
//  Created by Caner Tüysüz on 10.01.2025.
//

import Foundation

protocol HomepageRepositoryProtocol: AnyObject {
    func fetchAgents()
}

protocol HomepageRepositoryDelegate: AnyObject {
    func didFetchAgents(_ result: NetworkResult<AgentResponse>)
}

final class HomepageRepository: HomepageRepositoryProtocol {
    weak var delegate: HomepageRepositoryDelegate?
    
    func fetchAgents() {
        NetworkManager.shared.makeRequest(
            endpoint: HomepageEndpoints.getAgents,
            responseType: AgentResponse.self
        ) { [weak self] result in
            guard let self = self else { return }
            self.delegate?.didFetchAgents(result)
        }
    }
}
