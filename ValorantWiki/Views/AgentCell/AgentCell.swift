//
//  AgentCell.swift
//  ValorantWiki
//
//  Created by Caner Tüysüz on 27.12.2024.
//

import UIKit
import Foundation
import Kingfisher

final class AgentCell: UICollectionViewCell {
    
    var viewModel: AgentCellViewModelProtocol?
    
    @IBOutlet weak var agentImageView: UIImageView!
    @IBOutlet weak var agentNameLabel: UILabel!
    @IBOutlet weak var agentCellButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        agentNameLabel.text = nil
        agentImageView.image = nil
    }
    
    func setupUI() {
        agentNameLabel.textColor = .valorant
        agentNameLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        agentCellButton.tintColor = .valorant
        agentCellButton.setTitle("Details", for: .normal)
        agentImageView.kf.indicatorType = .activity
    }
    
    func loadAgent(with agent: Agent) {
        
        // viewModel?.configure(with agent: Agent)
        
        // move those configuration logic to cell's viewModel
        agentNameLabel.text = agent.displayName
        
        if let agentPortrait = agent.fullPortrait {
            let url = URL(string: agentPortrait)
            agentImageView.kf.setImage(with: url)
        }
    }
    
    @IBAction func navigateToDetailButtonTapped(_ sender: Any) {
        // viewModel?.navigateToDetailButtonTapped()
    }
    
}
