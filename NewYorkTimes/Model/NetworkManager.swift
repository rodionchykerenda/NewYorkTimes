//
//  NetworkManager.swift
//  NewYorkTimes
//
//  Created by Rodion Chikerenda on 16.02.2021.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol ListViewControllerDelegate {
    func didFinishDownloading(articles: [Article])
}

struct NetworkManager {
    let categoriesUrl = "https://api.nytimes.com/svc/search/v2/articlesearch.json?fq=news_desk:"
    let apiKey = "&api-key=0WW5RynA5Oc6Ivoe9P5oAODsSuFFDImX"
    var delegate: ListViewControllerDelegate?
    
    
    func getCharacters(_ selectedCategory: String) {
        var articlesArray = [Article]()
        let finalURL = categoriesUrl + selectedCategory + apiKey
        AF.request(finalURL).validate().responseJSON { response in
            guard let value = response.value else {fatalError("Failed loading articles data")}
            let jsonObject = JSON(value)
            let jsonArray = jsonObject["response"]["docs"].arrayValue
            for object in jsonArray {
                let snippet = object["abstract"].stringValue
                let webUrl = object["web_url"].stringValue
                let newArticle = Article(webUrl: webUrl, snippet: snippet)
                articlesArray.append(newArticle)
            }
            self.delegate?.didFinishDownloading(articles: articlesArray)
        }.resume()
    }
}
