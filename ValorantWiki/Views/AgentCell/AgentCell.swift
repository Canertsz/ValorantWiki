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
    var viewModel: AgentCellViewModelProtocol? {
        didSet {
            configureUI()
        }
    }
    
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
    
    private func configureUI() {
        agentNameLabel.text = viewModel?.agentDisplayName
        
        if let imageURL = viewModel?.agentPortraitURL {
            agentImageView.kf.setImage(with: imageURL)
        }
    }
    
    @IBAction func navigateToDetailButtonTapped(_ sender: Any) {
        viewModel?.navigateToDetailButtonTapped()
    }
    
}
