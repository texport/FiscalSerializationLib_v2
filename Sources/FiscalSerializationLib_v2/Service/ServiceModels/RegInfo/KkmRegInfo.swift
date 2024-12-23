//
//  KkmRegInfo.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 19.11.2024.
//

import Foundation

/// Класс `KkmRegInfo` предназначен для создания запросов и обработки ответов, связанных с регистрационной информацией кассового аппарата.
///
/// Содержит методы для формирования объектов `Kkm_Proto_KkmRegInfo` (запросов) и обработки объектов ответа от сервера оператора фискальных данных (ОФД).
///
/// ### Основные задачи:
/// 1. Проверка входных данных на валидность перед созданием запроса.
/// 2. Проверка корректности данных, полученных от ОФД, перед передачей разработчику.
///
/// В случае ошибок метод выбрасывает `NSError` с описанием проблемы.

struct KkmRegInfo {

    /// Создает объект `Kkm_Proto_KkmRegInfo` для запроса регистрационной информации.
    ///
    /// - Parameters:
    ///   - kgdId: Регистрационный номер КГД.
    ///   - kkmOfdId: Системный идентификатор кассового аппарата в ОФД.
    ///   - kkmSerialNumber: Серийный номер кассового аппарата.
    ///
    /// - Throws:
    ///   - `NSError` с кодом `1`, если `kgdId` пустой или состоит только из пробелов.
    ///   - `NSError` с кодом `2`, если `kkmOfdId` пустой или состоит только из пробелов.
    ///   - `NSError` с кодом `3`, если `kkmSerialNumber` пустой или состоит только из пробелов.
    ///
    /// - Returns: Объект `Kkm_Proto_KkmRegInfo` для отправки в запросе.
    static func createKkmRegInfoRequest(kgdId: String, kkmOfdId: String, kkmSerialNumber: String) throws -> Kkm_Proto_KkmRegInfo {
        // Проверка: ID КГД не должен быть пустым или состоять только из пробелов
        guard !kgdId.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw NSError(domain: "createKkmRegInfoRequest", code: 1, userInfo: [NSLocalizedDescriptionKey: "КГД ID(Регистрационный номер КГД) не может быть пустым или состоять только из пробелов."])
        }
        
        // Проверка: ID ОФД не должен быть пустым или состоять только из пробелов
        guard !kkmOfdId.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw NSError(domain: "createKkmRegInfoRequest", code: 2, userInfo: [NSLocalizedDescriptionKey: "KKM ID(Системный идентификатор ККМ в ОФД) не может быть пустым или состоять только из пробелов."])
        }
        
        // Проверка: Серийный номер не должен быть пустым или состоять только из пробелов
        guard !kkmSerialNumber.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw NSError(domain: "createKkmRegInfoRequest", code: 3, userInfo: [NSLocalizedDescriptionKey: "Серийный номер ККМ не может быть пустым или состоять только из пробелов."])
        }
        
        var kkmRegInfo = Kkm_Proto_KkmRegInfo()
        kkmRegInfo.fnsKkmID = kgdId
        kkmRegInfo.kkmID = kkmOfdId
        kkmRegInfo.serialNumber = kkmSerialNumber
        
        return kkmRegInfo
    }
    
    /// Обрабатывает объект ответа `Kkm_Proto_KkmRegInfo` от сервера ОФД.
    ///
    /// Проверяет корректность данных, полученных от ОФД. В случае некорректных данных выбрасывает `NSError`.
    ///
    /// - Parameters:
    ///   - kkmRegInfoResponse: Объект ответа `Kkm_Proto_KkmRegInfo` от сервера.
    ///
    /// - Throws:
    ///   - `NSError` с кодом `1`, если `fnsKkmID` пустой.
    ///   - `NSError` с кодом `2`, если `serialNumber` пустой.
    ///   - `NSError` с кодом `3`, если `kkmID` пустой.
    ///
    /// - Returns: Объект `KkmRegInfoResponse`, содержащий обработанные данные.
    static func createKkmRegInfoResponse(kkmRegInfoResponse: Kkm_Proto_KkmRegInfo) throws -> KkmRegInfoResponse {
        // Проверка: КГД ID не должен быть пустым
        guard !kkmRegInfoResponse.fnsKkmID.isEmpty else {
            throw NSError(domain: "createKkmRegInfoResponse", code: 1, userInfo: [NSLocalizedDescriptionKey: "ОФД НАРУШИЛ ПРОТОКОЛ: В ответе от ОФД был получен пустой КГД ID(Регистрационный номер КГД). Обратитесь в службу поддержки ОФД."])
        }
        
        // Проверка: Серийный номер не должен быть пустым
        guard !kkmRegInfoResponse.serialNumber.isEmpty else {
            throw NSError(domain: "createKkmRegInfoResponse", code: 2, userInfo: [NSLocalizedDescriptionKey: "ОФД НАРУШИЛ ПРОТОКОЛ: В ответе от ОФД был получен пустой Серийный номер ККМ. Обратитесь в службу поддержки ОФД."])
        }
        
        // Проверка: ID ОФД не должен быть пустым
        guard !kkmRegInfoResponse.kkmID.isEmpty else {
            throw NSError(domain: "createKkmRegInfoResponse", code: 3, userInfo: [NSLocalizedDescriptionKey: "ОФД НАРУШИЛ ПРОТОКОЛ: В ответе от ОФД был получен пустой KKM ID(Системный идентификатор ККМ в ОФД). Обратитесь в службу поддержки ОФД."])
        }
        
        return KkmRegInfoResponse.create(with: (kkmRegInfoResponse.fnsKkmID,
                                                kkmRegInfoResponse.serialNumber,
                                                kkmRegInfoResponse.kkmID))
    }
}
