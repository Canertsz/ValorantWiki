//
//  AgentDetailViewModel.swift
//  ValorantWiki
//
//  Created by Caner Tüysüz on 13.02.2025.
//

import Foundation

protocol AgentDetailViewModelProtocol {
    var agentDisplayName: String? { get }
    var agentPortraitURL: URL? { get }
    var agentRoleName: String? { get }
    var agentDescription: String? { get }
}

final class AgentDetailViewModel: AgentDetailViewModelProtocol {
    private let agent: Agent
    
    init(agent: Agent) {
        self.agent = agent
    }
    
    var agentDisplayName: String? {
        return agent.displayName
    }
    
    var agentRoleName: String? {
        return agent.role?.displayName
    }
    
    var agentDescription: String? {
        return agent.description
    }
    
    var agentPortraitURL: URL? {
        guard let portrait = agent.fullPortrait else { return nil }
        return URL(string: portrait)
    }
    
    
    
}
