//
//  URLRequest.swift
//  Cenfonet
//
//  Created by Walter  Barrantes on 21/6/21.
//

import Foundation

public extension URLRequest {
    
    init(stringUrl: String,
         method: HTTPMethod = .get,
         parameters: Parameters? = nil) {
        
        let url = URL(stringUrl: stringUrl,
                      method: method,
                      parameters: parameters)
        
        self.init(url: url)
        
        self.method = method
        self.httpMethod = method.rawValue
        
        self.setValue("application/json", forHTTPHeaderField: "Accept")
        self.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        switch method {
            case .post, .put:
                self.httpBody = parameters?.toData()
            default:
                break
        }
    }

    
    /// Returns the `httpMethod` as Cenfonet's `HTTPMethod` type.
    var method: HTTPMethod? {
        get { return httpMethod.flatMap(HTTPMethod.init) }
        set { httpMethod = newValue?.rawValue }
    }
}
