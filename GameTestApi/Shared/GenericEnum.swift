//
//  GenericEnums.swift
//  GamesTest
//
//  Created by Juan Aguilar on 04/08/25.
//

import Foundation

enum ErrorEnum: LocalizedError, Equatable {
    case networkError
    case decodingError
    case serverError(code: Int)
    case custom(message: String)
    case unknown
    
    var errorDescription: String {
        switch self {
        case .networkError:
            return "No hay conexión a internet. Por favor, verifica tu red."
        case .decodingError:
            return "Ocurrió un error al procesar los datos."
        case .serverError(let code):
            return "Error del servidor. Código: \(code)"
        case .custom(let message):
            return message
        case .unknown:
            return "Ocurrió un error desconocido. Inténtalo de nuevo."
        }
    }
}
