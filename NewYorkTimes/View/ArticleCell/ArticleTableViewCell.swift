//
//  ArticleTableViewCell.swift
//  NewYorkTimes
//
//  Created by Rodion Chikerenda on 16.02.2021.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var articleName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: -  Heplers
    static let identifier = "ArticleTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "ArticleTableViewCell", bundle: nil)
    }
    
    func update(articleText: String) {
        articleName.text = articleText
    }
}
