//
//  CardPaymentBuilder.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 01.11.2024.
//

import Foundation

/// Структура `CardPayment` для создания платежа с использованием банковской карты
struct CardPayment {
    private let billsCardSum: UInt64?
    private let coinsCardSum: UInt32?
    
    /// Инициализатор для создания объекта `CardPayment`
    /// - Parameters:
    ///   - billsCardSum: Сумма в целых единицах, оплаченная картой (если применимо)
    ///   - coinsCardSum: Сумма в дробных единицах, оплаченная картой (если применимо)
    init(billsCardSum: UInt64?, coinsCardSum: UInt32?) {
        self.billsCardSum = billsCardSum
        self.coinsCardSum = coinsCardSum
    }
    
    /// Метод для создания платежа с использованием банковской карты
    /// - Throws: Генерирует ошибку, если параметры некорректны или отсутствуют необходимые данные
    /// - Returns: Объект `Kkm_Proto_TicketRequest.Payment`, содержащий информацию о платеже картой
    func createCardPayment() throws -> Kkm_Proto_TicketRequest.Payment {
        var payment = Kkm_Proto_TicketRequest.Payment()
        
        // Если расчет картой, устанавливаем тип оплаты как картой
        payment.type = Kkm_Proto_PaymentTypeEnum.paymentCard
        
        // Проверка на наличие суммы оплаты картой
        guard let billsCardSum = billsCardSum, let coinsCardSum = coinsCardSum else {
            throw NSError(domain: "createCardPayment", code: 1, userInfo: [NSLocalizedDescriptionKey: "Отсутствует сумма оплаты картой."])
        }
        
        // Проверяем, что сумма мобильного платежа больше нуля
        guard billsCardSum > 0 || coinsCardSum > 0 else {
            throw NSError(domain: "createCardPayment", code: 2, userInfo: [NSLocalizedDescriptionKey: "Платеж картой не может быть 0."])
        }
        
        // Создаем сумму картой
        let money = Money()
        try payment.sum = money.createMoney(bills: billsCardSum, coins: coinsCardSum)
        
        return payment
    }
}
