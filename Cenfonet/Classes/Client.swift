//
//  Client.swift
//  Cenfonet
//
//  Created by Walter  Barrantes on 20/6/21.
//

import Foundation

public typealias CenfonetResult<T> = ((Result<T, ApiError>) -> Void)
public typealias Parameters = [String: Any]

public class Client {
    
    var session: URLSession
    
    public init(session: URLSession) {
        self.session = session
    }
    
    private func decodingTask<T: Decodable>(with request: URLRequest,
                                            decodingType: T.Type,
                                            completion:@escaping CenfonetResult<T>) -> URLSessionDataTask {
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed(description: error.debugDescription)))
                return
            }
            
            guard httpResponse.statusCode == 200 || httpResponse.statusCode == 201 else {
                completion(.failure(.responseUnsuccessful(description: "status code = \(httpResponse.statusCode)")))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let genericModel = try decoder.decode(T.self, from: data)
                completion(.success(genericModel))
            } catch let error {
                completion(.failure(.jsonConversionFailure(description: error.localizedDescription)))
            }
        }
        
        return task
    }
    
    public func fetch<T: Decodable>(type: T.Type,
                                    stringUrl: String,
                                    method: HTTPMethod = .get,
                                    parameters: Parameters? = nil,
                                    completion: @escaping CenfonetResult<T>) {
        
        let request = URLRequest.init(stringUrl: stringUrl,
                                      method: method,
                                      parameters: parameters)
        
        let task = decodingTask(with: request, decodingType: T.self) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        task.resume()
    }
}
