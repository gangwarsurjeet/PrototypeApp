//
//  NetworkManager.swift
//  PrototypeApp
//
//  Created by Surjeet on 30/03/21.
//
import Foundation

enum HttpMethod: String {
    case POST
    case GET
    case PUT
    case DELETE
}

enum ResponseCode: Int {
    case success = 200
    case notFound = 404
}

class NetworkManager {
    
    static let shared = NetworkManager()
    private let decoder = JSONDecoder()
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func performRequest<T: Decodable>(url: URL, type: HttpMethod, completion: @escaping(Result<T, Error>) -> Void) {

        var request = URLRequest(url: url)
        request.httpMethod = type.rawValue
        let task = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            DispatchQueue.main.async {
                if let _error = error {
                    completion(.failure(_error))
                } else {
                    if let response = urlResponse as? HTTPURLResponse, response.statusCode == ResponseCode.success.rawValue, let _data = data {
                        do {
                            
                            let parsedData = try self.decoder.decode(T.self, from: _data)
                            completion(.success(parsedData))
                        } catch {
                            completion(.failure(error))
                        }
                    } else if let response = urlResponse as? HTTPURLResponse {
                        // Error Code
                        let error = NSError(domain: "Some technical error occured", code: response.statusCode, userInfo: [:])
                        completion(.failure(error as Error))
                    }
                }
            }
        }
        task.resume()
    }
}
