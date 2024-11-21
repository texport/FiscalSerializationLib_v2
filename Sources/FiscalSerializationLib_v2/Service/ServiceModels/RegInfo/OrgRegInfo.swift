//
//  OrgRegInfo.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 19.11.2024.
//

import Foundation

/// Структура `OrgRegInfo` предоставляет методы для работы с регистрационной информацией об организации.
///
/// Основные задачи:
/// - Формирование запросов для отправки регистрационной информации об организации на сервер оператора фискальных данных (ОФД).
/// - Обработка ответов от сервера и преобразование их в удобный для разработчиков формат.
///
/// Структура проверяет входные данные на валидность перед формированием запросов и проверяет корректность данных, полученных от ОФД.
/// В случае ошибок выбрасываются исключения (`NSError`) с описанием проблемы.
///
/// ### Формат регистрационной информации:
/// - `title`: Название организации.
/// - `address`: Адрес организации.
/// - `iinOrBin`: Идентификационный номер налогоплательщика (ИИН/БИН).
/// - `oked`: Общереспубликанский классификатор экономической деятельности (ОКЭД).
struct OrgRegInfo {
    
    /// Создает объект `Kkm_Proto_OrgRegInfo` для запроса регистрационной информации об организации.
    ///
    /// - Parameters:
    ///   - title: Название организации.
    ///   - address: Адрес организации.
    ///   - iinOrBin: ИИН или БИН организации.
    ///   - oked: Код ОКЭД организации.
    ///
    /// - Throws:
    ///   - `NSError` с кодом `1`, если `title` пустой или состоит только из пробелов.
    ///   - `NSError` с кодом `2`, если `address` пустой или состоит только из пробелов.
    ///   - `NSError` с кодом `3`, если `iinOrBin` пустой или состоит только из пробелов.
    ///   - `NSError` с кодом `4`, если `oked` пустой или состоит только из пробелов.
    ///
    /// - Returns: Объект `Kkm_Proto_OrgRegInfo` для отправки в запросе.
    // TODO: Добавить валидации для метода createOrgRegInfoRequest, нужно проверять все поля на корректность заполнения
    static func createOrgRegInfoRequest(title: String, address: String, iinOrBin: String, oked: String) throws -> Kkm_Proto_OrgRegInfo {
        // Проверка: Название организации не должно быть пустым или состоять только из пробелов
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw NSError(
                domain: "createOrgRegInfoRequest",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "Название организации (title) не может быть пустым или состоять только из пробелов."]
            )
        }
        
        // Проверка: Адрес организации не должен быть пустым или состоять только из пробелов
        guard !address.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw NSError(
                domain: "createOrgRegInfoRequest",
                code: 2,
                userInfo: [NSLocalizedDescriptionKey: "Адрес организации (address) не может быть пустым или состоять только из пробелов."]
            )
        }
        
        // Проверка: ИИН/БИН не должен быть пустым или состоять только из пробелов
        guard !iinOrBin.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw NSError(
                domain: "createOrgRegInfoRequest",
                code: 3,
                userInfo: [NSLocalizedDescriptionKey: "ИИН/БИН организации (iinOrBin) не может быть пустым или состоять только из пробелов."]
            )
        }
        
        // Проверка: Код ОКЭД не должен быть пустым или состоять только из пробелов
        guard !oked.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw NSError(
                domain: "createOrgRegInfoRequest",
                code: 4,
                userInfo: [NSLocalizedDescriptionKey: "Код ОКЭД (oked) не может быть пустым или состоять только из пробелов."]
            )
        }
        
        var orgRegInfo = Kkm_Proto_OrgRegInfo()
        orgRegInfo.title = title
        orgRegInfo.address = address
        orgRegInfo.inn = iinOrBin
        orgRegInfo.okved = oked
        
        return orgRegInfo
    }
    
    /// Обрабатывает объект ответа `Kkm_Proto_OrgRegInfo` от сервера ОФД.
    ///
    /// - Parameters:
    ///   - orgRegInfoResponse: Объект ответа `Kkm_Proto_OrgRegInfo` от сервера.
    ///
    /// - Throws:
    ///   - `NSError` с кодом `1`, если `title` отсутствует или пустой.
    ///   - `NSError` с кодом `2`, если `address` отсутствует или пустой.
    ///   - `NSError` с кодом `3`, если `iinOrBin` отсутствует или пустой.
    ///   - `NSError` с кодом `4`, если `oked` отсутствует или пустой.
    ///
    /// - Returns: Объект `OrgRegInfoResponse`, содержащий данные об организации.
    static func createOrgRegInfoResponse(orgRegInfoResponse: Kkm_Proto_OrgRegInfo) throws -> OrgRegInfoResponse {
        // Проверка: Название организации не должно быть пустым
        guard !orgRegInfoResponse.title.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw NSError(
                domain: "createOrgRegInfoResponse",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "ОФД НАРУШИЛ ПРОТОКОЛ: Название организации (title) отсутствует или пустое. Обратитесь в службу поддержки ОФД."]
            )
        }
        
        // Проверка: Адрес организации не должен быть пустым
        guard !orgRegInfoResponse.address.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw NSError(
                domain: "createOrgRegInfoResponse",
                code: 2,
                userInfo: [NSLocalizedDescriptionKey: "ОФД НАРУШИЛ ПРОТОКОЛ: Адрес организации (address) отсутствует или пустой. Обратитесь в службу поддержки ОФД."]
            )
        }
        
        // Проверка: ИИН/БИН не должен быть пустым
        guard !orgRegInfoResponse.inn.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw NSError(
                domain: "createOrgRegInfoResponse",
                code: 3,
                userInfo: [NSLocalizedDescriptionKey: "ОФД НАРУШИЛ ПРОТОКОЛ: ИИН/БИН организации (iinOrBin) отсутствует или пустой. Обратитесь в службу поддержки ОФД."]
            )
        }
        
        // Проверка: Код ОКЭД не должен быть пустым
        guard !orgRegInfoResponse.okved.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw NSError(
                domain: "createOrgRegInfoResponse",
                code: 4,
                userInfo: [NSLocalizedDescriptionKey: "ОФД НАРУШИЛ ПРОТОКОЛ: Код ОКЭД (oked) отсутствует или пустой. Обратитесь в службу поддержки ОФД."]
            )
        }
        
        return OrgRegInfoResponse(
            title: orgRegInfoResponse.title,
            address: orgRegInfoResponse.address,
            iinOrBin: orgRegInfoResponse.inn,
            oked: orgRegInfoResponse.okved
        )
    }
}
