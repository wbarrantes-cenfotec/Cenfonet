//
//  URL.swift
//  Cenfonet
//
//  Created by Walter  Barrantes on 21/6/21.
//

import Foundation

public extension URL {
    
    init(stringUrl: String,
         method: HTTPMethod = .get) {
        
        let components = URLComponents(string: stringUrl)!
        self = components.url!
    }
    
    init(stringUrl: String,
         method: HTTPMethod = .get,
         parameters: Parameters? = nil) {
        
        var components = URLComponents(string: stringUrl)!
        
        switch method {
            case .get, .delete:
                components.queryItems = parameters?.map { key, value in
                    return URLQueryItem(name: key, value: value as? String)
                }
            default:
                break
        }
                
        self = components.url!
    }
}
