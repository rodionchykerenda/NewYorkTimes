//
//  CategoryCollectionViewCell.swift
//  NewYorkTimes
//
//  Created by Rodion Chikerenda on 16.02.2021.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryColor: UIView!
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var featuredImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Helpers
    static let identifier = "CategoryCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
    }
    
    // MARK: - Setters
    func update(_ category: Category) {
        categoryName.text = category.name
        featuredImage.image = category.featuredImage
    }
}
