//
//  DescriptionNewsCell.swift
//  NewsCode
//
//  Created by Arseni Khatsuk on 04.08.2022.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var webView = WKWebView()
    var spinner = UIActivityIndicatorView()
    
    var articleUrl:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        webView.navigationDelegate = self
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            webView.widthAnchor.constraint(equalTo: view.widthAnchor),
            webView.heightAnchor.constraint(equalTo: view.heightAnchor),
            webView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            webView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        logLifeCycle()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        logLifeCycle()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        logLifeCycle()
    }
    
    override func viewWillLayoutSubviews() {
        logLifeCycle()
    }
    
    override func viewDidLayoutSubviews() {
        logLifeCycle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Check that there's a url
        if articleUrl != nil {
            
            // Create the URL object
            let url = URL(string: articleUrl!)
            
            guard url != nil else {
                // Couldn't create the URL object
                return
            }
            
            // Create the URLRequest object
            let request = URLRequest(url: url!)
            
            // Start spinner
            spinner.alpha = 1
            spinner.startAnimating()
            
            // Load it in the webview
            webView.load(request)
            
            logLifeCycle()
        }
    }
}

extension DetailViewController:WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Stop the spinner and  hide it
        spinner.stopAnimating()
        spinner.alpha = 0
    }
}

