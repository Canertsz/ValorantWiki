//
//  AgentCellViewModel.swift
//  ValorantWiki
//
//  Created by Caner Tüysüz on 11.01.2025.
//

import Foundation

protocol AgentCellViewModelProtocol {
    var agentDisplayName: String? { get }
    var agentPortraitURL: URL? { get }
    func navigateToDetailButtonTapped()
}

protocol AgentCellViewModelDelegate: AnyObject {
    func didTapAgentCellDetailButton(agent: Agent)
}

final class AgentCellViewModel: AgentCellViewModelProtocol {
    private let agent: Agent
    weak var delegate: AgentCellViewModelDelegate?
    
    init(agent: Agent, delegate: AgentCellViewModelDelegate) {
        self.agent = agent
        self.delegate = delegate
    }
    
    var agentDisplayName: String? {
        return agent.displayName
    }
    
    var agentPortraitURL: URL? {
        guard let portrait = agent.fullPortrait else { return nil }
        return URL(string: portrait)
    }
    
    func navigateToDetailButtonTapped() {
        delegate?.didTapAgentCellDetailButton(agent: agent)
    }
}
