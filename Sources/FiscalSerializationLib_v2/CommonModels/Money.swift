//
//  Money.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 01.11.2024.
//

import Foundation

/// Структура `Money` для создания объекта `Kkm_Proto_Money` с проверкой допустимых значений
/// Эта структура обеспечивает безопасное создание денежной суммы с целыми и дробными частями,
/// гарантируя, что передаваемые значения корректны.
struct Money {
    
    /// Создает объект `Kkm_Proto_Money` с проверкой допустимых значений
    /// - Parameters:
    ///   - bills: Сумма в целых единицах (не должна быть отрицательной)
    ///   - coins: Сумма в дробных единицах (должна быть в диапазоне от 0 до 99)
    /// - Throws: Генерирует ошибку, если значения выходят за пределы допустимого диапазона
    /// - Returns: Объект `Kkm_Proto_Money` с проверенными значениями
    func createMoney(bills: UInt64, coins: UInt32) throws -> Kkm_Proto_Money {
        // Проверка: сумма монет должна быть в диапазоне от 0 до 99
        guard coins < 100 else {
            throw NSError(domain: "createMoney", code: 1, userInfo: [NSLocalizedDescriptionKey: "Сумма монет должна быть в диапазоне от 0 до 99."])
        }
        
        var money = Kkm_Proto_Money()
        money.bills = bills
        money.coins = coins

        return money
    }
}
