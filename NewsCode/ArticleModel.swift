//
//  ArticleModel.swift
//  NewsCode
//
//  Created by Arseni Khatsuk on 05.08.2022.
//

import Foundation

protocol ArticleModernProtocol {
    
    func articleRetrived(_ article:[Article])
}

class ArticleModel {
    
    var delegate:ArticleModernProtocol?
    enum NetworkError: Error {
        case badURL, unknown
    }
    func getArticles(completion: ((Result<[Article], Error>) -> Void)? = nil) {
        
        // Fire off the request to the API
        
        // Create a string URL
        let stringUrl = "https://newsapi.org/v2/top-headlines?country=ru&category=business&apiKey=a55901b3a2a64d83beac49ea7846248d"
        
        // Create a URL object
        let url = URL(string: stringUrl)
      
        // Check that it isn't a nil
        guard url != nil else {
            completion?(.failure(NetworkError.badURL))
            print("Coudn't create url object")
            return
        }
       
        // Get the URL Session
        let session = URLSession.shared
        
        // Create the data task
        let dataTask = session.dataTask(with: url!) { data, response, error in
            
            // Check that there are no errors and that there is data
            guard error == nil, let data = data else {
                completion?(.failure(NetworkError.badURL))
                return
            }
        
                // Attempt to parse the JSON
                let decoder = JSONDecoder()
                
                do{
                    
                    // Parse the json into ArticleService
                    let articleService = try decoder.decode(ArticleService.self, from: data)
                    
                    // Get the articles
                    if  let articles = articleService.articles {
                        
                        // Pass it back to the view controller in the main thread
                        DispatchQueue.main.async {
                            completion?(.success(articles))
                            self.delegate?.articleRetrived(articles)
                        }
                  
                    }
                }
                catch{
                    
                    print("error parsing the json")
                    
                } // End Do - Catch
                
            } // End if
        dataTask.resume()
            
        } // End Data Task
        
        // Start the data task
        
    }

