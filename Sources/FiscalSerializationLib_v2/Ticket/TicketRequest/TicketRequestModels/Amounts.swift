//
//  Amounts.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 05.11.2024.
//

import Foundation

/// Структура `Amounts` предназначена для создания объекта `Kkm_Proto_TicketRequest.Amounts`,
/// который представляет собой общий итог чека, включая общую сумму, полученные платежи,
/// сдачу и скидку.
///
/// Структура содержит методы для проверки корректности данных, расчета сдачи
/// и построения итогового объекта `Kkm_Proto_TicketRequest.Amounts`.
struct Amounts {
    // MARK: - Public Methods
        
    /// Создает объект `Kkm_Proto_TicketRequest.Amounts` с проверкой корректности данных.
    ///
    /// - Parameters:
    ///   - payments: Список платежей.
    ///   - total: Общая сумма чека.
    ///   - taken: Сумма, полученная от клиента (опционально).
    ///   - discount: Скидка (опционально).
    /// - Throws: Ошибка, если список платежей пуст или при оплате наличными не указана сумма `taken`.
    /// - Returns: Объект типа `Kkm_Proto_TicketRequest.Amounts`.
    func createAmounts(payments: [Kkm_Proto_TicketRequest.Payment],
                               total: Kkm_Proto_Money,
                               taken: Kkm_Proto_Money?,
                               discount: Kkm_Proto_TicketRequest.Modifier?) throws -> Kkm_Proto_TicketRequest.Amounts {
        guard payments.count > 0 else {
            throw NSError(domain: "InvalidAmounts", code: 1, userInfo: [NSLocalizedDescriptionKey: "Не может быть такой ситуации, когда нет платежей вообще, в payments пусто"])
        }
        
        // Проверка: если есть единственный тип оплаты наличными и только он
        let onlyCashPayment = payments.count == 1 && payments.first?.type == .paymentCash
                
        var change: Kkm_Proto_Money? = nil
        
        if onlyCashPayment {
            guard let taken = taken else {
                throw NSError(domain: "InvalidAmounts", code: 2, userInfo: [NSLocalizedDescriptionKey: "При оплате только наличными должна быть указана полученная сумма (taken)."])
            }
            
            // Рассчитываем сдачу, если чек полностью оплачен наличными
            change = calculateChange(total: total, taken: taken)
        }
        
        return buildAmounts(total: total, taken: taken, change: change, discount: discount)
    }
    
    // MARK: - Private Helper Methods
    
    /// Рассчитывает сдачу на основе общей суммы и полученной суммы.
    ///
    /// - Parameters:
    ///   - total: Общая сумма чека.
    ///   - taken: Сумма, полученная от клиента.
    /// - Returns: Объект типа `Kkm_Proto_Money`, представляющий сдачу.
    private func calculateChange(total: Kkm_Proto_Money, taken: Kkm_Proto_Money) -> Kkm_Proto_Money {
        var changeBills = (taken.bills >= total.bills) ? (taken.bills - total.bills) : 0
        var changeCoins = (taken.coins >= total.coins) ? (taken.coins - total.coins) : 0
        
        // TODO: Перенести это в структуру Money
        // Учитываем пересчет монет в купюры, если нужно
        if taken.coins < total.coins && taken.bills > 0 {
            changeCoins = (taken.coins + 100) - total.coins
            changeBills -= 1
        }
        
        var calculatedChange = Kkm_Proto_Money()
        calculatedChange.bills = changeBills
        calculatedChange.coins = changeCoins
        
        return calculatedChange
    }
    
    /// Создает и возвращает объект `Kkm_Proto_TicketRequest.Amounts` с заданными параметрами.
    ///
    /// - Parameters:
    ///   - total: Общая сумма чека.
    ///   - taken: Сумма, полученная от клиента (опционально).
    ///   - change: Сдача (опционально).
    ///   - discount: Скидка (опционально).
    /// - Returns: Объект типа `Kkm_Proto_TicketRequest.Amounts`.
    private func buildAmounts(total: Kkm_Proto_Money,
                                  taken: Kkm_Proto_Money?,
                                  change: Kkm_Proto_Money?,
                              discount: Kkm_Proto_TicketRequest.Modifier?) -> Kkm_Proto_TicketRequest.Amounts {
        var amounts = Kkm_Proto_TicketRequest.Amounts()
        amounts.total = total
        
        if let taken = taken {
            amounts.taken = taken
        }
        
        if let change = change {
            amounts.change = change
        }
        
        if let discount = discount {
            amounts.discount = discount
        }
        
        return amounts
    }
}
