//
//  Networking.swift
//  RikiMorty
//
//  Created by Ravshanbek Tursunbaev on 18.08.2023.
//

import Foundation

final class Networking {
    
    func request(urlString: String?, completion: @escaping (_ data: Data?, _ error: NetworkingError?) -> Void) {
        guard let urlString else { completion(nil, NetworkingError.invalidURL); return }
        guard let url = URL(string: urlString) else { completion(nil, NetworkingError.failedToConvertToURL); return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
           
            guard error == nil else {
                print("Response with Error: \(error!)")
                completion(nil, NetworkingError.reponseWithError)
                return
            }
            
            guard let response, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(nil, NetworkingError.badResponse)
                return
            }
            guard let data else { completion(nil, NetworkingError.dataNotFound); return }
            completion(data, nil)
        }.resume()
    }
    
    func decode<T: Codable>(from data: Data, to model: T.Type) throws -> T {
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(model, from: data)
            return result
        } catch {
            throw NetworkingError.failedToDecode
        }
    }
}

extension Networking {
    enum NetworkingError: Error {
        case invalidURL
        case failedToConvertToURL
        case reponseWithError
        case badResponse
        case dataNotFound
        case failedToDecode
    }
}
