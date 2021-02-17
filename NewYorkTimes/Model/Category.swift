//
//  Category.swift
//  NewYorkTimes
//
//  Created by Rodion Chikerenda on 16.02.2021.
//

import UIKit

struct Category {
    var featuredImage: UIImage
    var name: String
    
    static func fetchCategory() -> [Category] {
        return [
        Category(featuredImage: #imageLiteral(resourceName: "SportsImage"), name: "Sports"),
        Category(featuredImage: #imageLiteral(resourceName: "BooksImage"), name: "Books"),
        Category(featuredImage: #imageLiteral(resourceName: "CarsImage"), name: "Cars")]
    }
}
