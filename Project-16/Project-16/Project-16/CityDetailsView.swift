//
//  CityDetailsView.swift
//  Project-16
//
//  Created by Sagar Kadam on 16/07/22.
//

import UIKit
import WebKit

class CityDetailsView: UIViewController, WKNavigationDelegate {
    var cityTitle: String?
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = cityTitle
        webView = WKWebView()
        webView.navigationDelegate = self
        navigateToWebPage()
        
    }
    
    func navigateToWebPage() {
        var webURL = ""
        switch cityTitle {
        case "London":
            webURL = "https://en.wikipedia.org/wiki/London"
        case "Oslo":
            webURL = "https://en.wikipedia.org/wiki/Oslo"
        case "Paris":
            webURL = "https://en.wikipedia.org/wiki/Paris"
        case "Rome":
            webURL = "https://en.wikipedia.org/wiki/Rome"
        case "Washington DC":
            webURL = "https://en.wikipedia.org/wiki/Washington,_D.C."
        default:
            webURL = "https://en.wikipedia.org/wiki/London"
        }
        webView.load(URLRequest(url: URL(string: webURL)!))
        view = webView
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
}
