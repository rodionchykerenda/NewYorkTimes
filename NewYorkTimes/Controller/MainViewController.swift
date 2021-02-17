//
//  ViewController.swift
//  NewYorkTimes
//
//  Created by Rodion Chikerenda on 16.02.2021.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var contentCollectionView: UICollectionView!
    
    var dataSource = Category.fetchCategory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDelegates()
        styleUI()
    }
    
    // MARK: -  Helpers
    func styleUI() {
        self.title = "Categories"
        navigationController?.navigationBar.prefersLargeTitles = true
        contentCollectionView.showsHorizontalScrollIndicator = false
    }
    
    func setUpDelegates() {
        contentCollectionView.delegate = self
        contentCollectionView.dataSource = self
        contentCollectionView.register(CategoryCollectionViewCell.nib(), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    }
}

// MARK: -  UICollectionView Additional Mehods
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = contentCollectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else {
            fatalError("Unable to dequeue CharacterCell")
        }
        cell.update(dataSource[indexPath.row])
        cell.layer.cornerRadius = 20
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStroyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = mainStroyboard.instantiateViewController(identifier: "ListViewController") as! ListViewController
        destinationVC.selectedCategory = dataSource[indexPath.row].name
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}

