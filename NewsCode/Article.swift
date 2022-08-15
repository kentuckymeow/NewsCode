//
//  Article.swift
//  NewsCode
//
//  Created by Arseni Khatsuk on 05.08.2022.
//

import Foundation

struct Article : Decodable {
    
    var author:String?
    var title:String?
    var description:String?
    var url:String?
    var urlToImage:String?
    var publishedAt:String?
    
}
