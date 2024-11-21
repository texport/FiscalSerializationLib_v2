//
//  RegInfo.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 19.11.2024.
//

import Foundation

/// Структура `RegInfo` предоставляет методы для обработки регистрационной информации, возвращаемой сервером оператора фискальных данных (ОФД).
///
/// Основная задача структуры — преобразовать ответ от сервера в удобный для использования формат, проверяя корректность и обязательность данных.
/// В случае ошибок метод выбрасывает `NSError` с подробным описанием проблемы.
///
/// ### Основные задачи:
/// - Обработка регистрационной информации о кассовом аппарате (`KkmRegInfo`).
/// - Обработка информации о торговой точке (`PosRegInfo`).
/// - Обработка информации об организации (`OrgRegInfo`).
///
/// Все данные проверяются на соответствие требованиям протокола перед передачей разработчику.
struct RegInfo {

    /// Создает объект ответа `RegInfoResponse`, объединяющий информацию о кассе, торговой точке и организации.
    ///
    /// - Parameters:
    ///   - regInfoResponse: Объект ответа `Kkm_Proto_ServiceResponse.RegInfo`, содержащий данные от сервера ОФД.
    ///
    /// - Throws:
    ///   - `NSError`, если какие-либо данные в ответе от сервера некорректны или отсутствуют.
    ///
    /// - Returns: Объект `RegInfoResponse`, содержащий обработанные данные.
    static func createRegInfoResponse(regInfoResponse: Kkm_Proto_ServiceResponse.RegInfo) throws -> RegInfoResponse {
        // Проверяем наличие обязательных компонентов
        guard regInfoResponse.hasKkm else {
            throw NSError(domain: "createRegInfoResponse", code: 1, userInfo: [
                NSLocalizedDescriptionKey: "ОФД НАРУШИЛ ПРОТОКОЛ: Отсутствует информация о кассовом аппарате. Обратитесь в службу поддержки ОФД."
            ])
        }
        
        guard regInfoResponse.hasPos else {
            throw NSError(domain: "createRegInfoResponse", code: 2, userInfo: [
                NSLocalizedDescriptionKey: "ОФД НАРУШИЛ ПРОТОКОЛ: Отсутствует информация о торговой точке. Обратитесь в службу поддержки ОФД."
            ])
        }
        
        guard regInfoResponse.hasOrg else {
            throw NSError(domain: "createRegInfoResponse", code: 3, userInfo: [
                NSLocalizedDescriptionKey: "ОФД НАРУШИЛ ПРОТОКОЛ: Отсутствует информация об организации. Обратитесь в службу поддержки ОФД."
            ])
        }
        
        // Обрабатываем информацию о кассе
        let kkm = try setupKkmRegInfoResponse(regInfoResponse: regInfoResponse)
        
        // Обрабатываем информацию о торговой точке
        let pos = try setupPosRegInfoResponse(regInfoResponse: regInfoResponse)
        
        // Обрабатываем информацию об организации
        let org = try setupOrgRegInfoResponse(regInfoResponse: regInfoResponse)
        
        return RegInfoResponse(kkm: kkm, pos: pos, org: org)
    }
    
    /// Обрабатывает регистрационную информацию о кассовом аппарате (`KkmRegInfo`).
    ///
    /// - Parameters:
    ///   - regInfoResponse: Объект ответа `Kkm_Proto_ServiceResponse.RegInfo`.
    ///
    /// - Throws:
    ///   - `NSError`, если данные о кассовом аппарате некорректны или отсутствуют.
    ///
    /// - Returns: Объект `KkmRegInfoResponse`, содержащий данные о кассовом аппарате.
    private static func setupKkmRegInfoResponse(regInfoResponse: Kkm_Proto_ServiceResponse.RegInfo) throws -> KkmRegInfoResponse {
        try KkmRegInfo.createKkmRegInfoResponse(kkmRegInfoResponse: regInfoResponse.kkm)
    }
    
    /// Обрабатывает информацию о торговой точке (`PosRegInfo`).
    ///
    /// - Parameters:
    ///   - regInfoResponse: Объект ответа `Kkm_Proto_ServiceResponse.RegInfo`.
    ///
    /// - Throws:
    ///   - `NSError`, если данные о торговой точке некорректны или отсутствуют.
    ///
    /// - Returns: Объект `PosRegInfoResponse`, содержащий данные о торговой точке.
    private static func setupPosRegInfoResponse(regInfoResponse: Kkm_Proto_ServiceResponse.RegInfo) throws -> PosRegInfoResponse {
        try PosRegInfo.createPosRegInfoResponse(posRegInfoResponse: regInfoResponse.pos)
    }
    
    /// Обрабатывает информацию об организации (`OrgRegInfo`).
    ///
    /// - Parameters:
    ///   - regInfoResponse: Объект ответа `Kkm_Proto_ServiceResponse.RegInfo`.
    ///
    /// - Throws:
    ///   - `NSError`, если данные об организации некорректны или отсутствуют.
    ///
    /// - Returns: Объект `OrgRegInfoResponse`, содержащий данные об организации.
    private static func setupOrgRegInfoResponse(regInfoResponse: Kkm_Proto_ServiceResponse.RegInfo) throws -> OrgRegInfoResponse {
        try OrgRegInfo.createOrgRegInfoResponse(orgRegInfoResponse: regInfoResponse.org)
    }
}
