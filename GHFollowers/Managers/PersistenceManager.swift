//
//  PersistenceManager.swift
//  GHFollowers
//
//  Created by Aaditya Singh on 12/12/22.
//

import UIKit


enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favourites = "favourites"
    }
    
    static func updateWith(favourite: Follower, actionType: PersistenceActionType, completed: @escaping (ErrorMessage?) -> Void) {
        retrieveFavourites { result in
            switch result {
            case .success(let favourites):
                var retrievedFav = favourites
                
                switch actionType {
                case .add:
                    guard !retrievedFav.contains(favourite) else {
                        completed(.alreadyIn)
                        return
                    }
                    retrievedFav.append(favourite)
                case.remove:
                    retrievedFav.removeAll {$0.login == favourite.login}
                }
                
                completed(save(favourites: retrievedFav))
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retrieveFavourites(completed: @escaping (Result<[Follower], ErrorMessage>) -> Void) {
        guard let favourites = defaults.object(forKey: Keys.favourites) as? Data else {
            completed(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
            let favourites = try decoder.decode([Follower].self, from: favourites)
            completed(.success(favourites))
        } catch {
            completed(.failure(.unableatoFav))
        }
    }
    
    
    static func save(favourites: [Follower]) -> ErrorMessage? {
        do {
            let encoder = JSONEncoder()
            let encodedFavourites = try encoder.encode(favourites)
            defaults.set(encodedFavourites, forKey: Keys.favourites)
            return nil
        } catch {
            return .unableatoFav
        }
    }
    
    
}


