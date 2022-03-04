//
//  NetworkManager.swift
//  Assessment
//
//  Created by Arvin Quiliza on 3/3/22.
//

import UIKit

protocol NetworkManagerProtocol {
    func getPhotos(completion: @escaping (Result<[Photo], TAError>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    
    static let cache = NSCache<NSString, UIImage>()
    
    /**
     * Fetch list of photos from API. Will Return a Result set type containing an array of photo or an error if encountered.
     *  - Parameters:
     *      - completion: handler to invoke passing the result type which is either a list of photo or an error.
     */
    func getPhotos(completion: @escaping (Result<[Photo], TAError>) -> Void) {
        guard let baseUrl = URL(string: Network.baseUrl) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: baseUrl) { data, response, error in
            
            // if error is present
            guard error == nil else {
                completion(.failure(.unableToComplete))
                return
            }
            
            // if response is not OK
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            // if data is nil
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let photos = try decoder.decode(Photos.self, from: data)
                
                completion(.success(photos))
            } catch {
                // if there's an issue in decoding
                completion(.failure(.unableToDecode))
            }
        }
        
        task.resume()
    }
    
    /**
     * Get the image to display using the downloadUrl in the api. This returns an optional image.
     *  - Parameters:
     *      - urlString: the url to get the image resource
     *      - completion: handler to invoke passing the optional image downloaded.
     */
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        // return the image if its already in our cache
        if let image = NetworkManager.cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                      completion(nil)
                      return
                  }
            
            // cache our image
            NetworkManager.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }
        
        task.resume()
    }
}
