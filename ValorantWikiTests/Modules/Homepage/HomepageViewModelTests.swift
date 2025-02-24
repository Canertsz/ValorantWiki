//
//  ValorantWikiTests.swift
//  ValorantWikiTests
//
//  Created by Caner Tüysüz on 14.02.2025.
//

import XCTest
@testable import ValorantWiki

final class HomePageViewModelTests: XCTestCase {
    private var viewModel: HomepageViewModel!
    private var view: MockHomepageVC!
    private var repository: MockHomepageRepository!
    private var coordinator: MockHomepageCoordinator!
    
    @MockData(resourceName: "MockAgentResponse.json")
    var mockAgentResponse: AgentResponse!
    
    override func setUp() {
        super.setUp()
        
        view = .init()
        coordinator = .init()
        repository = .init()
        
        viewModel = .init(view: view,
                          repository: repository,
                          coordinator: coordinator)
    }
    
    override func tearDown() {
        super.tearDown()
        repository = nil
        coordinator = nil
        view = nil
    }
    
    func test_viewDidLoad_InvokesNecessaryMethods() {
        XCTAssertTrue(view.reloadCollectionViewCallCount == .zero)
        XCTAssertTrue(view.setupUICallCount == .zero)
        XCTAssertTrue(repository.fetchAgentsCallCount == .zero)
        
        viewModel.viewDidLoad()
        
        XCTAssertTrue(view.reloadCollectionViewCallCount == .zero)
        XCTAssertTrue(view.setupUICallCount == 1)
        XCTAssertTrue(repository.fetchAgentsCallCount == 1)
    }
    
    func test_agent_returnsAgentWhenInRange() throws {
        XCTAssertNil(viewModel.agent(for: .init(row: .zero, section: .zero)))
        viewModel.didFetchAgents(.success(mockAgentResponse))
        let returnedAgent = viewModel.agent(for: .init(row: .zero, section: .zero))
        let unwrappedAgent = try XCTUnwrap(returnedAgent)
        XCTAssertEqual(mockAgentResponse.data?.first?.uuid, unwrappedAgent.uuid)
    }
    
    func test_agent_returnsNilWhenOutOfRange() {
        viewModel.didFetchAgents(.success(mockAgentResponse!))
        XCTAssertNil(viewModel.agent(for: .init(row: mockAgentResponse.data!.count + 1, section: .zero)))
    }
    
    func test_didTapAgentCellDetailButton_navigatesToAgentDetail() {
        let agent = mockAgentResponse.data?.first
        
        viewModel.didTapAgentCellDetailButton(agent: agent!)
        XCTAssertTrue(coordinator.didNavigateToAgentDetails)
        XCTAssertEqual(coordinator.navigatedAgent, agent)
    }
    
    func test_didFetchAgents_UpdatesAgents() {
        XCTAssertEqual(viewModel.numberOfItemsInSection, .zero)
        viewModel.didFetchAgents(.success(mockAgentResponse))
        XCTAssertEqual(mockAgentResponse.data?.count, viewModel.numberOfItemsInSection)
    }
    
    func test_searchAgents_ShouldReturnAllAgentsWhenSearchTextEmpty() {
        viewModel.searchAgents(with: "")
        
        XCTAssertEqual(viewModel.numberOfItemsInSection, viewModel.numberOfItemsInSection)
    }
    
    func test_searchAgents_ShouldReturnCorrectAmountOfAgent() {
        viewModel.didFetchAgents(.success(mockAgentResponse!))
        viewModel.searchAgents(with: "Jett")
        
        XCTAssertEqual(viewModel.numberOfItemsInSection, 1)
    }
    
    func test_searchAgents_ShouldReturnCorrectAgentWhenMatching() {
        viewModel.didFetchAgents(.success(mockAgentResponse!))
        viewModel.searchAgents(with: "Jett")
        
        XCTAssertEqual(viewModel.agent(for: .init(row: .zero, section: .zero))?.displayName, "Jett")
    }
    
    func test_searchAgents_IsCaseInsensitive() {
        viewModel.didFetchAgents(.success(mockAgentResponse!))
        viewModel.searchAgents(with: "phoenix")
        
        XCTAssertEqual(viewModel.numberOfItemsInSection, 1)
        XCTAssertEqual(viewModel.agent(for: .init(row: .zero, section: .zero))?.displayName, "Phoenix")
    }
    
    func testSearchAgents_StartsWithMatching() {
        viewModel.didFetchAgents(.success(mockAgentResponse!))
        viewModel.searchAgents(with: "Deadloc")
        
        XCTAssertEqual(viewModel.numberOfItemsInSection, 1)
        XCTAssertEqual(viewModel.agent(for: .init(row: .zero, section: .zero))?.displayName, "Deadlock")
    }
    
    func test_filteringAgents_InvokesNecessaryMethods() {
        XCTAssertTrue(view.reloadCollectionViewCallCount == .zero)
        
        viewModel.filteringAgents()
        
        XCTAssertTrue(view.reloadCollectionViewCallCount == 1)
    }
}
