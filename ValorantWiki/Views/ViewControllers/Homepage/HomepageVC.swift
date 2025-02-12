//
//  HomepageVC.swift
//  ValorantWiki
//
//  Created by Caner Tüysüz on 20.12.2024.
//

import UIKit

class HomepageVC: UIViewController, HomepageViewModelDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: HomepageViewModelProtocol?
    
    func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        viewModel?.delegate = self
        
        collectionView.register(nibWithCellClass: AgentCell.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel?.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width / 3,
                                 height: view.frame.width / 2)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Enter Search Here",
                                                                             attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        
        searchBar.searchTextField.leftView?.tintColor = .white
        
        searchBar.searchTextField.textColor = .white
    }
    
    func didFetchAgents() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension HomepageVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.agents?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(AgentCell.self, indexPath: indexPath)
        
        cell.layer.borderColor = UIColor.border.cgColor
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 1
        
        if let agent = viewModel?.agents?[indexPath.item] {
            cell.loadAgent(with: agent)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.frame.width / 2.3, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 20, left: 20, bottom: 5, right: 20)
    }
}

extension HomepageVC: StoryboardInstantiable {
    static var storyboardName: String { "Homepage" }
    static var identifier: String { "HomepageVC" }
}
