//
//  HomepageVC.swift
//  ValorantWiki
//
//  Created by Caner Tüysüz on 20.12.2024.
//

import UIKit

protocol HomepageViewProtocol: AnyObject {
    func setupUI()
    func reloadCollectionView()
}

private extension HomepageVC {
    enum Constant {
        static let cornerRadius: CGFloat = 10.0
        static let borderWidth: CGFloat = 1
    }
}

final class HomepageVC: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: HomepageViewModelProtocol! // private lazy?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Enter agent name",
                                                                             attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        
        searchBar.searchTextField.leftView?.tintColor = .white
        
        searchBar.searchTextField.textColor = .white
    }
}

// MARK: - HomepageViewProtocol
extension HomepageVC: HomepageViewProtocol {
    func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(nibWithCellClass: AgentCell.self)
        searchBar.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width / 3,
                                 height: view.frame.width / 2)
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension HomepageVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(AgentCell.self, indexPath: indexPath)
        
        cell.layer.borderColor = UIColor.border.cgColor
        cell.layer.cornerRadius = Constant.cornerRadius
        cell.layer.borderWidth = Constant.borderWidth
        
        guard let agent = viewModel.agent(for: indexPath) else { return cell }
        let vm = AgentCellViewModel(agent: agent, delegate: viewModel)
        cell.viewModel = vm
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.frame.width / 2.3, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 20, left: 20, bottom: 5, right: 20)
    }
}

extension HomepageVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchAgents(with: searchText)
        viewModel.filteringAgents()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        viewModel.searchAgents(with: "")
        viewModel.filteringAgents()
    }
}

extension HomepageVC: StoryboardInstantiable {
    static var storyboardName: String { "Homepage" }
    static var identifier: String { "HomepageVC" }
}
