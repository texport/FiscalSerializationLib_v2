//
//  PosRegInfo.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 19.11.2024.
//

import Foundation

/// Структура `PosRegInfo` предназначена для обработки регистрационной информации о торговой точке.
///
/// Обрабатывает ответ от сервера и преобразует его в удобный формат для внутренней работы библиотеки.
/// Проверяет обязательные поля, такие как `title` и `address`, на их наличие и заполненность.

struct PosRegInfo {
    
    /// Обрабатывает объект ответа `Kkm_Proto_PosRegInfo` от сервера ОФД.
    ///
    /// Проверяет обязательные поля `title` и `address` на их наличие и корректность.
    ///
    /// - Parameters:
    ///   - posRegInfoResponse: Объект ответа `Kkm_Proto_PosRegInfo` от сервера.
    ///
    /// - Throws:
    ///   - `NSError` с кодом `1`, если `title` отсутствует или пустой.
    ///   - `NSError` с кодом `2`, если `address` отсутствует или пустой.
    ///
    /// - Returns: Объект `PosRegInfoResponse`, содержащий данные о торговой точке.
    static func createPosRegInfoResponse(posRegInfoResponse: Kkm_Proto_PosRegInfo) throws -> PosRegInfoResponse {
        // Проверка: Название торговой точки не должно быть пустым
        guard !posRegInfoResponse.title.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw NSError(
                domain: "createPosRegInfoResponse",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "ОФД НАРУШИЛ ПРОТОКОЛ: Название торговой точки (title) отсутствует или пустое. Обратитесь в службу поддержки ОФД."]
            )
        }
        
        // Проверка: Адрес торговой точки не должен быть пустым
        guard !posRegInfoResponse.address.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw NSError(
                domain: "createPosRegInfoResponse",
                code: 2,
                userInfo: [NSLocalizedDescriptionKey: "ОФД НАРУШИЛ ПРОТОКОЛ: Адрес торговой точки (address) отсутствует или пустой. Обратитесь в службу поддержки ОФД."]
            )
        }
        
        return PosRegInfoResponse.create(with: (title: posRegInfoResponse.title, address: posRegInfoResponse.address))
    }
}
