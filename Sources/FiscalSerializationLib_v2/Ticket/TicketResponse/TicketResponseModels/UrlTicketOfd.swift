//
//  UrlTicketOfd.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 07.11.2024.
//

import Foundation

/// Структура `UrlTicketOfd` предназначена для обработки URL-адресов фискальных чеков, возвращаемых оператором фискальных данных (ОФД).
///
/// Метод `createUrlTicketOfd` проверяет, что входные данные корректно преобразуются в строку и что эта строка является допустимым URL.
struct UrlTicketOfd {
    
    /// Создаёт строку URL на основе данных.
    ///
    /// - Parameter urlTicketOfd: Данные типа `Data`, содержащие URL в виде строки.
    ///
    /// - Returns: Строка, представляющая корректный URL.
    ///
    /// - Throws:
    ///   - Ошибка с кодом `1`, если данные не могут быть преобразованы в строку.
    ///   - Ошибка с кодом `2`, если строка не является допустимым URL.
    static func createUrlTicketOfd(urlTicketOfd: Data) throws -> String {
        // Преобразуем Data в строку
        guard let urlString = String(data: urlTicketOfd, encoding: .utf8) else {
            throw NSError(
                domain: "UrlTicketOfd",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "Невозможно преобразовать данные в строку."]
            )
        }
        
        // Проверка, что строка является корректным URL
        guard let url = URL(string: urlString), url.scheme != nil, url.host != nil else {
            throw NSError(
                domain: "UrlTicketOfd",
                code: 2,
                userInfo: [NSLocalizedDescriptionKey: "Строка не является допустимым URL."]
            )
        }
        
        return urlString
    }
}
