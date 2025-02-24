//
//  AgentCellViewModelTests.swift
//  ValorantWiki
//
//  Created by Caner Tüysüz on 19.02.2025.
//

import XCTest
@testable import ValorantWiki

final class AgentCellViewModelTests: XCTestCase {
    private var viewModel: AgentCellViewModel!
    private var mockDelegate: MockAgentCellViewModelDelegate!
    
    @MockData(resourceName: "MockAgentResponse.json")
    var mockAgentResponse: AgentResponse!
    
    override func setUp() {
        super.setUp()
        
        mockDelegate = .init()
        viewModel = .init(agent: mockAgentResponse.data!.first!,
                          delegate: mockDelegate)
    }
    
    override func tearDown() {
        super.tearDown()
        mockDelegate = nil
    }
    
    func test_displayName_returnsAgentDisplayName() {
        XCTAssertEqual(viewModel.agentDisplayName, mockAgentResponse.data?.first?.displayName)
    }
    
    func test_imageURL_returnsAgentimageURL() {
        XCTAssertEqual(viewModel.agentPortraitURL?.absoluteString, mockAgentResponse.data?.first?.fullPortrait)
    }
    
    func test_navigateToDetailButtonTapped_callsDidTapAgentCellDetailButton() {
        XCTAssertEqual(mockDelegate.didTapAgentCellDetailButtonCallCount, .zero)
        let agent = mockAgentResponse.data?.first
        mockDelegate.didTapAgentCellDetailButton(agent: agent!)
        XCTAssertEqual(mockDelegate.didTapAgentCellDetailButtonCallCount, 1)
    }
}
