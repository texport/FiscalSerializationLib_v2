//
//  RegInfo.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 19.11.2024.
//

import Foundation

/// Структура `RegInfo` предоставляет методы для обработки и формирования регистрационной информации.
///
/// Основные задачи структуры:
/// - Преобразование ответа от сервера оператора фискальных данных (ОФД) в удобный для использования формат.
/// - Формирование запросов с регистрационной информацией для передачи на сервер ОФД.
/// - Проверка корректности и обязательности данных в соответствии с требованиями протокола.
///
/// ### Основные функции:
/// - Создание запросов для передачи информации о кассовом аппарате и организации.
/// - Обработка данных, полученных от сервера, включая:
///   - Регистрационную информацию о кассовом аппарате (`KkmRegInfo`).
///   - Информацию о торговой точке (`PosRegInfo`).
///   - Информацию об организации (`OrgRegInfo`).
///
/// ### Исключения:
/// В случае ошибок структура выбрасывает `NSError` с подробным описанием проблемы.
/// Все данные проверяются на соответствие требованиям протокола перед передачей разработчику или серверу.
struct RegInfo {
    
    /// Создает объект запроса `Kkm_Proto_ServiceRequest.RegInfo`, объединяющий информацию о кассе и организации.
    ///
    /// - Parameters:
    ///   - kgdId: Регистрационный номер КГД.
    ///   - kkmOfdId: Системный идентификатор кассового аппарата в ОФД.
    ///   - kkmSerialNumber: Серийный номер кассового аппарата.
    ///   - title: Название организации.
    ///   - address: Адрес организации.
    ///   - iinOrBin: ИИН или БИН организации.
    ///   - oked: Код экономической деятельности (ОКЭД).
    ///
    /// - Throws:
    ///   - `NSError`, если данные для создания запроса некорректны или отсутствуют.
    ///
    /// - Returns: Объект `Kkm_Proto_ServiceRequest.RegInfo`, готовый для отправки.
    static func createRegInfoRequest(kgdId: String, kkmOfdId: String, kkmSerialNumber: String, title: String, address: String, iinOrBin: String, oked: String) throws -> Kkm_Proto_ServiceRequest.RegInfo {
        var regInfo = Kkm_Proto_ServiceRequest.RegInfo()
        
        regInfo.kkm = try setupKkmRegInfoRequest(kgdId: kgdId, kkmOfdId: kkmOfdId, kkmSerialNumber: kkmSerialNumber)
        regInfo.org = try setupOrgRegInfoRequest(title: title, address: address, iinOrBin: iinOrBin, oked: oked)
        
        return regInfo
    }
    
    /// Создает информацию о кассовом аппарате (`KkmRegInfo`) для запроса.
    ///
    /// - Parameters:
    ///   - kgdId: Регистрационный номер КГД.
    ///   - kkmOfdId: Системный идентификатор кассового аппарата в ОФД.
    ///   - kkmSerialNumber: Серийный номер кассового аппарата.
    ///
    /// - Throws:
    ///   - `NSError`, если данные для создания информации о кассовом аппарате некорректны.
    ///
    /// - Returns: Объект `Kkm_Proto_KkmRegInfo`, готовый для использования в запросе.
    private static func setupKkmRegInfoRequest(kgdId: String, kkmOfdId: String, kkmSerialNumber: String) throws -> Kkm_Proto_KkmRegInfo {
        try KkmRegInfo.createKkmRegInfoRequest(kgdId: kgdId, kkmOfdId: kkmOfdId, kkmSerialNumber: kkmSerialNumber)
    }
    
    /// Создает информацию об организации (`OrgRegInfo`) для запроса.
    ///
    /// - Parameters:
    ///   - title: Название организации.
    ///   - address: Адрес организации.
    ///   - iinOrBin: ИИН или БИН организации.
    ///   - oked: Код экономической деятельности (ОКЭД).
    ///
    /// - Throws:
    ///   - `NSError`, если данные для создания информации об организации некорректны.
    ///
    /// - Returns: Объект `Kkm_Proto_OrgRegInfo`, готовый для использования в запросе.
    private static func setupOrgRegInfoRequest(title: String, address: String, iinOrBin: String, oked: String) throws -> Kkm_Proto_OrgRegInfo {
        try OrgRegInfo.createOrgRegInfoRequest(title: title, address: address, iinOrBin: iinOrBin, oked: oked)
    }
    
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
        
        return RegInfoResponse.create(with: (kkm, pos, org))
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
