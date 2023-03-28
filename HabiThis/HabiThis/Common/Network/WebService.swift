//
//  WebService.swift
//  HabiThis
//
//  Created by user on 13/03/23.
//

import Foundation


enum WebService {
    
    enum EndPoint: String {
        case base = "https://habitplus-api.tiagoaguiar.co"
        
        case postUser = "/users"
        case login = "/auth/login"
        case refreshToken = "/auth/refresh-token"
    }
    
    enum NetworkError {
        case badRequest
        case notFound
        case unauthorized
        case internalServerError
    }
    
    enum Method: String {
        case get
        case post
        case put
        case delete
    }
    
    enum Result {
        case success(Data)
        case failure(NetworkError, Data?)
    }
    
    enum ContentType: String {
        case json = "application/json"
        case formUrl = "application/x-www-form-urlencode"
    }
    
    private static func  completeUrl(path: EndPoint) -> URLRequest? {
        guard let url = URL(string: "\(EndPoint.base.rawValue)\(path.rawValue)") else { return nil }
        return URLRequest(url: url)
    }
    
    public static func call(path: EndPoint,
                            method: Method,
                            contentType: ContentType,
                            data: Data?,
                            completion: @escaping (Result) -> Void) {
        
        guard var urlRequest = completeUrl(path: path) else { return }
        
        _ = LocalDataSource.shared.getUserAuth()
            .sink { userAuth in
                if let userAuth = userAuth {
                    urlRequest.setValue("\(userAuth.tokenType) \(userAuth.idToken)", forHTTPHeaderField: "Authorization")
                }
                urlRequest.httpMethod = method.rawValue
                urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
                urlRequest.setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
                urlRequest.httpBody = data
                
                let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                    guard let data = data, error == nil else {
                        completion(.failure(.internalServerError, nil))
                        return
                    }
                    if let r = response as? HTTPURLResponse {
                        switch r.statusCode {
                        case 400:
                            completion(.failure(.badRequest, data))
                            break
                        case 401:
                            completion(.failure(.unauthorized, data))
                        case 200:
                            completion(.success(data))
                        default:
                            break
                        }
                    }
                    print(String(data: data, encoding: .utf8))
                    print("response: \(response)")
                }
                task.resume()
            }
    }
    
    public static func call<T: Encodable>(path: EndPoint,
                                          method: Method = .get,
                                          body: T,
                                          completion: @escaping (Result) -> Void) {
        
        guard let jsonData = try? JSONEncoder().encode(body) else { return }
        
        call(path: path, method: method, contentType: .json, data: jsonData, completion: completion)
    }
    
    public static func call(path: EndPoint,
                            method: Method = .post,
                            params: [URLQueryItem],
                            completion: @escaping (Result) -> Void) {
        
        guard let urlRequest = completeUrl(path: path) else { return }
        guard let absoluteURL = urlRequest.url?.absoluteString else { return }
        var components = URLComponents(string: absoluteURL)
        components?.queryItems = params
        
        call(path: path,
             method: method,
             contentType: .formUrl,
             data: components?.query?.data(using: .utf8),
             completion: completion)
    }
}
