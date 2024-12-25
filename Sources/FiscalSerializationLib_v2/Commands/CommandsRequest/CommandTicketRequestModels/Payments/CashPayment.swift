//
//  CashPayment.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 01.11.2024.
//

import Foundation

/// Структура `CashPayment` для создания платежа с использованием наличных денег
struct CashPayment {
    private let billsCashSum: UInt64?
    private let coinsCashSum: UInt32?
    
    /// Инициализатор для создания объекта `CashPayment`
    /// - Parameters:
    ///   - billsCashSum: Сумма в целых единицах, оплаченная наличными (если применимо)
    ///   - coinsCashSum: Сумма в дробных единицах, оплаченная наличными (если применимо)
    init(billsCashSum: UInt64?, coinsCashSum: UInt32?) {
        self.billsCashSum = billsCashSum
        self.coinsCashSum = coinsCashSum
    }
    
    /// Метод для создания платежа с использованием наличных денег
    /// - Throws: Генерирует ошибку, если параметры некорректны или отсутствуют необходимые данные
    /// - Returns: Объект `Kkm_Proto_TicketRequest.Payment`, содержащий информацию о платеже наличными
    func createCashPayment() throws -> Kkm_Proto_TicketRequest.Payment {
        var payment = Kkm_Proto_TicketRequest.Payment()
        
        // Если расчет наличными, устанавливаем тип оплаты как наличные
        payment.type = Kkm_Proto_PaymentTypeEnum.paymentCash
        
        // Проверка на наличие суммы оплаты наличными
        guard let billsCashSum = billsCashSum, let coinsCashSum = coinsCashSum else {
            throw NSError(domain: "createCashPayment", code: 1, userInfo: [NSLocalizedDescriptionKey: "Отсутствует сумма оплаты наличными."])
        }
        
        // Создаем сумму наличными
        let money = Money()
        try payment.sum = money.createMoney(bills: billsCashSum, coins: coinsCashSum)
        
        return payment
    }
}
