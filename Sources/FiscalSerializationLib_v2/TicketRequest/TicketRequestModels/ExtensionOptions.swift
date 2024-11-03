//
//  ExtensionOptions.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 01.11.2024.
//

import Foundation

/// Структура `ExtensionOptions` используется для создания объекта `Kkm_Proto_TicketRequest.ExtensionOptions`,
/// который содержит информацию о покупателе, такую как телефон, email и ИИН/БИН.
/// Структура обеспечивает валидацию данных и выбрасывает ошибки при недопустимых значениях.
struct ExtensionOptions {
    
    /// Создает объект `Kkm_Proto_TicketRequest.ExtensionOptions` с информацией о клиенте.
    /// Проверяет правильность формата переданных данных для телефона, email и ИИН/БИН.
    /// - Parameters:
    ///   - phone: Номер телефона клиента в формате "+7XXXXXXXXXX" (опционально).
    ///   - email: Адрес электронной почты клиента в формате "example@example.com" (опционально).
    ///   - iinOrBin: ИИН или БИН клиента, состоящий из 12 цифр (опционально).
    /// - Throws: Генерирует ошибку, если:
    ///   - Не передано ни одно из полей `phone`, `email` или `iinOrBin`.
    ///   - Формат номера телефона неверный.
    ///   - Формат адреса электронной почты неверный.
    ///   - Формат ИИН/БИН неверный.
    /// - Returns: Объект `Kkm_Proto_TicketRequest.ExtensionOptions` с заполненными данными клиента.
    func createExtensionOptions(phone: String?, email: String?, iinOrBin: String?) throws -> Kkm_Proto_TicketRequest.ExtensionOptions {
        guard phone != nil || email != nil || iinOrBin != nil else {
            throw NSError(domain: "createExtensionOptions", code: 1, userInfo: [NSLocalizedDescriptionKey: "Необходимо указать хотя бы одно из полей: телефон, email или ИИН/БИН."])
        }
        
        var customer = Kkm_Proto_TicketRequest.ExtensionOptions()
        customer.auxiliary = [Kkm_Proto_KeyValuePair]()
        
        if let phone = phone {
            try validatePhone(phone)
            customer.customerPhone = phone
        }
        
        if let email = email {
            try validateEmail(email)
            customer.customerEmail = email
        }
        
        if let iinOrBin = iinOrBin {
            try validateIinOrBin(iinOrBin)
            customer.customerIinOrBin = iinOrBin
        }
        
        return customer
    }
    
    /// Проверяет корректность номера телефона.
    /// - Parameter phone: Номер телефона клиента в формате "+7XXXXXXXXXX".
    /// - Throws: Генерирует ошибку, если номер телефона не соответствует формату.
    private func validatePhone(_ phone: String) throws {
        let phoneRegex = "^\\+7\\d{10}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        guard phonePredicate.evaluate(with: phone) else {
            throw NSError(domain: "validatePhone", code: 2, userInfo: [NSLocalizedDescriptionKey: "Неверный формат телефона. Ожидается формат +7XXXXXXXXXX."])
        }
    }
    
    /// Проверяет корректность адреса электронной почты.
    /// - Parameter email: Адрес электронной почты клиента в формате "example@example.com".
    /// - Throws: Генерирует ошибку, если адрес электронной почты не соответствует формату.
    private func validateEmail(_ email: String) throws {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        guard emailPredicate.evaluate(with: email) else {
            throw NSError(domain: "validateEmail", code: 3, userInfo: [NSLocalizedDescriptionKey: "Неверный формат email."])
        }
    }
    
    /// Проверяет корректность ИИН или БИН.
    /// - Parameter iinOrBin: ИИН или БИН клиента, состоящий из 12 цифр.
    /// - Throws: Генерирует ошибку, если ИИН или БИН не соответствует формату.
    private func validateIinOrBin(_ iinOrBin: String) throws {
        let iinOrBinRegex = "^\\d{12}$"
        let iinOrBinPredicate = NSPredicate(format: "SELF MATCHES %@", iinOrBinRegex)
        guard iinOrBinPredicate.evaluate(with: iinOrBin) else {
            throw NSError(domain: "validateIinOrBin", code: 4, userInfo: [NSLocalizedDescriptionKey: "Неверный формат ИИН/БИН. Ожидается 12-значное число, содержащее только цифры."])
        }
    }
}
