//
//  GPBEndpoint.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/13/22.
//

import Foundation
import Alamofire

enum GPBEndpoint: URLConvertible {
    
    case bookListsOverview
    
    case bookByList(_ listName: String)
    
    
    private var baseURL: String {
        return AppConstants.BaseURL
    }
    
    func asURL() throws -> URL {
        return url
    }
    
    var url: URL {
        let urlComponents = NSURLComponents(string: baseURL.appending(apiPath))
        
        if (urlComponents?.queryItems == nil) {
            urlComponents!.queryItems = []
        }
        urlComponents!.queryItems!.append(contentsOf: [URLQueryItem(name: "api-key", value: AppConstants.apiKey)])
        
        return urlComponents!.url!
    }
    
    
    private var apiPath: String {
        switch self {
            
        case .bookListsOverview:
            return "/lists/overview.json"
            
        case .bookByList(let name):
            return "/lists/current/\(name).json"
            
            
            
        }
    }
    
}
