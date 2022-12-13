//
//  ErrorMessage.swift
//  GHFollowers
//
//  Created by Aaditya Singh on 09/12/22.
//

import Foundation


enum ErrorMessage: String, Error {
    
    case invalidUsername = "This user does not exist."
    case unableToCompleteRequest = "There was a problem with the request. check yout internet"
    case invalidResponse = "Invalid request"
    case invalidData = "The data received was invalid please try again"
    case unableatoFav = "There was an error favouriting this user"
    case alreadyIn = "You have already favourited this user"
    
}
