//
//  HttpHeader.swift
//  Cenfonet
//
//  Created by Walter  Barrantes on 21/6/21.
//

import Foundation

public enum HTTPHeader {
    
    case contentType(String)
    case accept(String)
    case authorization(String)
    
    var header: (field: String, value: String) {
        
        switch self {
            case .contentType(let value):
                return (field: "Content-Type", value: value)
            case .accept(let value):
                return (field: "Accept", value: value)
            case .authorization(let value):
                return (field: "Authorization", value: value)
        }
    }
}
