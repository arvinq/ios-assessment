//
//  TAError.swift
//  Assessment
//
//  Created by Arvin Quiliza on 3/3/22.
//

import Foundation

enum TAError: String, Error {
    case invalidUrl       = "Invalid Request. Please contact the administrator."
    case invalidResponse  = "Invalid Response from the server. Please try again."
    case invalidData      = "Invalid Data Received. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your network connection and try again."
    case unableToDecode   = "Unable to decode the data. Please check if you're decoding your data correctly."
}
