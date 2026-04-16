//
//  AppError.swift
//  RavenNYTimes
//
//  Created by Isaí Abraham Innova on 16/04/26.
//

import Foundation

enum AppError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError
    case networkError(String)
    case coreDataError(String)
    case unknown
    case noInternetAndNoLocalData

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "La URL es inválida."
        case .invalidResponse:
            return "La respuesta del servidor no es válida."
        case .decodingError:
            return "No se pudieron leer los datos."
        case .networkError(let message):
            return "Error de red: \(message)"
        case .coreDataError(let message):
            return "Error local: \(message)"
        case .noInternetAndNoLocalData:
            return "No hay conexión a internet y no existen datos guardados localmente."
        case .unknown:
            return "Ocurrió un error desconocido."
        }
    }
}
