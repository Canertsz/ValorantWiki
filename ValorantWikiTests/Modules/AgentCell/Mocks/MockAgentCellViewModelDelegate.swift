//
//  MockAgentCellViewModelDelegate.swift
//  ValorantWiki
//
//  Created by Caner Tüysüz on 19.02.2025.
//

import Foundation
@testable import ValorantWiki

final class MockAgentCellViewModelDelegate: AgentCellViewModelDelegate {
    
    var didTapAgentCellDetailButtonCallCount = 0
    var didTapAgentCellDetailButtonParameter: Agent?
    func didTapAgentCellDetailButton(agent: Agent) {
        didTapAgentCellDetailButtonParameter = agent
        didTapAgentCellDetailButtonCallCount += 1
    }
}
