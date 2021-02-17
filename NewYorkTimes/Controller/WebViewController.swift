//
//  WebViewController.swift
//  NewYorkTimes
//
//  Created by Rodion Chikerenda on 16.02.2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var selectedURL: String?
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(URLRequest(url: URL(string: selectedURL ?? "https://www.google.com") ?? URL(string: "https://www.google.com")!))
    }
}
