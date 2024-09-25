//
//  NetworkError.swift
//  CodingExercise
//
//  Created by Prashant Gautam on 24/09/24.
//

import Foundation

enum NetworkError: LocalizedError {
    case badUrl
    case badRequest          // 400
    case unauthorized        // 401
    case forbidden           // 403
    case notFound            // 404
    case methodNotAllowed    // 405
    case requestTimeout      // 408
    case internalServerError // 500
    case notImplemented      // 501
    case badGateway          // 502
    case serviceUnavailable  // 503
    case gatewayTimeout      // 504
    case unknown(code: Int)  // For unexpected status codes

    // Initialize the enum based on an HTTP status code
    init(statusCode: Int) {
        switch statusCode {
        case 400:
            self = .badRequest
        case 401:
            self = .unauthorized
        case 403:
            self = .forbidden
        case 404:
            self = .notFound
        case 405:
            self = .methodNotAllowed
        case 408:
            self = .requestTimeout
        case 500:
            self = .internalServerError
        case 501:
            self = .notImplemented
        case 502:
            self = .badGateway
        case 503:
            self = .serviceUnavailable
        case 504:
            self = .gatewayTimeout
        default:
            self = .unknown(code: statusCode)
        }
    }
    
    var errorDescription: String? {
        switch self {
        case .badUrl:
            return "Invalid or wrong url"
        case .badRequest:
            return "Bad Request"
        case .unauthorized:
            return "Unauthorized access"
        case .forbidden:
            return "Forbidden"
        case .notFound:
            return "Resource not found"
        case .methodNotAllowed:
            return "Method Not Allowed"
        case .requestTimeout:
            return "Request Timeout"
        case .internalServerError:
            return "Internal Server Error"
        case .notImplemented:
            return "Not Implemented"
        case .badGateway:
            return "Bad Gateway"
        case .serviceUnavailable:
            return "Service Unavailable"
        case .gatewayTimeout:
            return "Gateway Timeout"
        case .unknown(code: let code):
            return "Unknown error with code '\(code)'"
        }
       
    }
}

enum DataPersistenceError: LocalizedError {
    case save
    case fetch
    case unknown

    var errorDescription: String? {
        switch self {
        case .save:
            return "Data save error"
        case .fetch:
            return "Data fetch error"
        case .unknown :
            return "Unknown error"
        }
       
    }
}

