//
//  ListViewController.swift
//  NewYorkTimes
//
//  Created by Rodion Chikerenda on 16.02.2021.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var contentTableView: UITableView!
    
    var selectedCategory: String?
    
    var spinner: UIActivityIndicatorView?
    
    var dataSource = [Article]() {
        didSet {
            contentTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDelegates()
        styleUI()
        loadData()
    }
    
    // MARK: -  Helpers
    func styleUI() {
        self.title = selectedCategory ?? "Sports"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = UIColor(named: "NavigationBarTitleColor")
    }
    
    func setUpDelegates() {
        contentTableView.delegate = self
        contentTableView.dataSource = self
        contentTableView.register(ArticleTableViewCell.nib(), forCellReuseIdentifier: ArticleTableViewCell.identifier)
    }
    
    func loadData() {
        var networkManager = NetworkManager()
        networkManager.delegate = self
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.spinner = UIActivityIndicatorView(style: .medium)
                self.spinner?.startAnimating()
                self.contentTableView.tableFooterView = self.spinner
            }
            networkManager.getCharacters(self.selectedCategory ?? "Sport")
        }
    }
}

// MARK: -  UITableView Delegate DataSource
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = contentTableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.identifier, for: indexPath) as? ArticleTableViewCell else {
            fatalError("Unable to dequeue CharacterCell")
        }
        cell.selectionStyle = .none 
        cell.update(articleText: dataSource[indexPath.row].snippet)
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row % 2 == 1 {
            cell.contentView.backgroundColor = UIColor(named: "ListColor")
        } else {
            cell.contentView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStroyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = mainStroyboard.instantiateViewController(identifier: "WebViewController") as! WebViewController
        destinationVC.selectedURL = dataSource[indexPath.row].webUrl
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}

// MARK: - ListViewControllerDelegate
extension ListViewController: ListViewControllerDelegate {
    func didFinishDownloading(articles: [Article]) {
        contentTableView.tableFooterView = nil
        spinner = nil
        dataSource = articles
    }
}

