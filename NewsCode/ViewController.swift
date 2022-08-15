//
//  ViewController.swift
//  NewsCode
//
//  Created by Arseni Khatsuk on 27.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var model = ArticleModel()
    var articles = [Article]()
    
    let cellId: String = "NewsCell"
    
    override func loadView() {
        view = UIView()
        logLifeCycle()
        
    }
//
//    override func loadViewIfNeeded() {
//        logLifeCycle()
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logLifeCycle()
        view.backgroundColor = UIColor.white
        navigationItem.title = "News"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsCell.self, forCellReuseIdentifier: cellId)
        model.getArticles { [weak self] result in
            switch result {
                
            case .success(let articles):
                self?.articles = articles
                self?.tableView.reloadData()
            case .failure(let error):
                print("error")
            }
        }
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
   }
    
    override func viewWillAppear(_ animated: Bool) {
        logLifeCycle()
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
    
    let tableView = UITableView.init(frame: .zero, style: UITableView.Style.grouped)

    func prepare(for controller: UIViewController, sender: Any?) {
        
        // Detect the indexpath the user selected
        let indexPath = tableView.indexPathForSelectedRow
        
        guard indexPath != nil else {
            // The user hasn't selected anything
            return
        }
        
        // Get the article the user tapped on
        let article = articles[indexPath!.row]
        
        // Get a reference to the detail view controller
        let detailVC = controller.presentingViewController as! DetailViewController
        
        // Pass the article url to the detail view controller
        detailVC.articleUrl = article.url!
        
    }

}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? NewsCell else {
//            return UITableViewCell()
//        }
//        cell.configure(with: models[indexPath.row])
//        return cell
        
        // Get a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! NewsCell
        
        // Get the article that the tableView is asking about
        let article = articles[indexPath.row]
        
        // Customize it
        cell.displaArticle(article)
        
        // Return the cell
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let model = self.models[indexPath.row]
        //let descriptionNewsCell = DetailViewController()
        //descriptionNewsCell.thumbnail.image = model.image
        let detailVC = DetailViewController()
        let article = articles[indexPath.row]
        detailVC.articleUrl = article.url
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

extension NSObject {
    func logLifeCycle(name: String = #function) {
        let controllerName = String(describing: Self.self)
        print()
        print("\(name) called in \(String(describing: controllerName))")
        print()
        
    }
}










