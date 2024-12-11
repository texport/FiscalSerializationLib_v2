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
    
    /// Преобразует объект `Kkm_Proto_Money` в значение типа `Double`
    /// - Parameter protoMoney: Объект `Kkm_Proto_Money`
    /// - Returns: Значение в формате "тенге.тиыны" с двумя знаками после запятой
    static func toDouble(protoMoney: Kkm_Proto_Money) -> Double {
        let bills = Double(protoMoney.bills)
        let coins = Double(protoMoney.coins) / 100.0
        return bills + coins
    }
    
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
    // TODO: Сделать автоматически пересчет из coins в bills если coins > 99
}
