//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Aaditya Singh on 09/12/22.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://api.github.com/users/"
    
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getFollowers(for userName: String, page: Int, completed: @escaping (Result<[Follower], ErrorMessage>) -> Void) {
        let endpoint = baseURL + "\(userName)/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToCompleteRequest))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode <= 300 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let follower = try decoder.decode([Follower].self, from: data)
                completed(.success(follower))
            } catch {
                completed(.failure(.unableToCompleteRequest))
            }
        }
        
        task.resume()
    }
    
    
    func getUserInfo(for userName: String, completed: @escaping (Result<User, ErrorMessage>) -> Void) {
        let endpoint = baseURL + "\(userName)"
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToCompleteRequest))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode <= 300 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
            } catch {
                completed(.failure(.unableToCompleteRequest))
            }
        }
        
        task.resume()
    }
    
    func downloadImageFromUrl(from urlString: String, completed: @escaping (UIImage?) -> Void) {
            
            let cacheKey = NSString(string: urlString)
            
            if let image = cache.object(forKey: cacheKey) {
                    completed(image)
                return
            }
            guard let url = URL(string: urlString) else {
                completed(nil)
                return}
            
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let self = self,
                      error == nil,
                      let response = response as? HTTPURLResponse,
                      let data = data,
                      let image = UIImage(data: data)
                      else {
                    completed(nil)
                    return }
                self.cache.setObject(image, forKey: cacheKey)
                completed(image)
            }
            task.resume()
    }
}
