//
//  AgentDetailVC.swift
//  ValorantWiki
//
//  Created by Caner Tüysüz on 12.02.2025.
//

import UIKit

final class AgentDetailVC: UIViewController {
    var viewModel: AgentDetailViewModelProtocol!
    
    @IBOutlet weak var agentPortrait: UIImageView!
    @IBOutlet weak var agentNameLabel: UILabel!
    @IBOutlet weak var agentRoleLabel: UILabel!
    @IBOutlet weak var agentDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureUI()
    }
    
    func setupUI() {
        
    }
    
    private func configureUI() {
        agentNameLabel.text = viewModel?.agentDisplayName
        agentRoleLabel.text = viewModel?.agentRoleName
        agentDescriptionLabel.text = viewModel?.agentDescription
        
        if let imageURL = viewModel?.agentPortraitURL {
            agentPortrait.kf.setImage(with: imageURL)
        }
        
        agentPortrait.hero.id = "agentImage_\(viewModel.agentDisplayName ?? "0")"
    }

}

extension AgentDetailVC: StoryboardInstantiable {
    static var storyboardName: String { "AgentDetail" }
    static var identifier: String { "AgentDetailVC" }
}
