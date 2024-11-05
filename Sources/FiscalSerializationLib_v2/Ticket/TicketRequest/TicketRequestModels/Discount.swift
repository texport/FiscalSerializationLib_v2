//
//  Discount.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 04.11.2024.
//

import Foundation

/// Структура `Discount` представляет скидку, которая может быть добавлена к чеку.
///
/// Предоставляет функциональность для создания модификаторов скидок с обязательной валидацией.
struct Discount {
    /// Создает модификатор скидки.
    ///
    /// - Parameters:
    ///   - name: Название скидки.
    ///   - sum: Сумма скидки в формате `Kkm_Proto_Money`.
    /// - Throws: Ошибка, если имя скидки пустое или сумма меньше либо равна нулю.
    /// - Returns: Объект типа `Kkm_Proto_TicketRequest.Modifier`.
    func createDicountModifier(name: String, sum: Kkm_Proto_Money) throws -> Kkm_Proto_TicketRequest.Modifier {
        try validateName(name)
        try validateSum(sum)
        
        var modifier = Kkm_Proto_TicketRequest.Modifier()
        
        modifier.name = name
        modifier.sum = sum
        modifier.taxes = [Kkm_Proto_TicketRequest.Tax]()
        modifier.auxiliary = [Kkm_Proto_KeyValuePair]()
        
        return modifier
    }
    
    // MARK: - Private Validation Methods
    
    /// Проверяет, что имя модификатора не пустое и не состоит только из пробелов.
    ///
    /// - Parameter name: Имя модификатора.
    /// - Throws: Ошибка, если имя модификатора пустое или состоит только из пробелов.
    private func validateName(_ name: String) throws {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw NSError(domain: "validateNameDiscount", code: 1, userInfo: [NSLocalizedDescriptionKey: "Имя модификатора не может быть пустым или состоять только из пробелов."])
        }
    }
    
    /// Проверяет, что сумма корректна и больше нуля.
    ///
    /// - Parameter sum: Сумма модификатора в формате `Kkm_Proto_Money`.
    /// - Throws: Ошибка, если сумма меньше или равна нулю.
    private func validateSum(_ sum: Kkm_Proto_Money) throws {
        guard sum.bills > 0 || sum.coins > 0 else {
            throw NSError(domain: "validateSumDiscount", code: 2, userInfo: [NSLocalizedDescriptionKey: "Сумма модификатора должна быть больше нуля."])
        }
    }
}
