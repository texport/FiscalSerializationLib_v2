//
//  MobilePaymentBuilder.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 01.11.2024.
//

import Foundation

/// Структура `MobilePayment` для создания мобильного платежа (например, с использованием QR-кода).
/// Используется для формирования объекта мобильного платежа с определенной суммой
struct MobilePayment {
    private let billsMobileSum: UInt64?
    private let coinsMobileSum: UInt32?
    
    /// Инициализатор для создания объекта `MobilePayment`.
    /// - Parameters:
    ///   - billsMobileSum: Сумма в целых единицах, оплаченная мобильным платежом.
    ///   - coinsMobileSum: Сумма в дробных единицах, оплаченная мобильным платежом.
    /// Оба параметра должны быть больше нуля для успешного создания объекта платежа.
    init(billsMobileSum: UInt64?, coinsMobileSum: UInt32?) {
        self.billsMobileSum = billsMobileSum
        self.coinsMobileSum = coinsMobileSum
    }
    
    /// Метод для создания платежа с использованием мобильного платежа.
    /// - Throws: Генерирует ошибку, если суммы мобильного платежа некорректны или отсутствуют.
    /// - Returns: Объект `Kkm_Proto_TicketRequest.Payment`, содержащий информацию о мобильном платеже.
    /// Ошибки:
    /// - Ошибка с кодом 1: Если суммы `billsMobileSum` или `coinsMobileSum` не заданы.
    /// - Ошибка с кодом 2: Если суммы `billsMobileSum` или `coinsMobileSum` равны нулю.
    func createMobilePayment() throws -> Kkm_Proto_TicketRequest.Payment {
        var payment = Kkm_Proto_TicketRequest.Payment()
        
        // Устанавливаем тип оплаты как мобильный платеж
        payment.type = Kkm_Proto_PaymentTypeEnum.paymentMobile
        
        // Проверяем наличие суммы оплаты мобильным платежом
        guard let billsMobileSum = billsMobileSum, let coinsMobileSum = coinsMobileSum else {
            throw NSError(domain: "createMobilePayment", code: 1, userInfo: [NSLocalizedDescriptionKey: "Отсутствует сумма мобильного платежа."])
        }
        
        // Проверяем, что сумма мобильного платежа больше нуля
        guard billsMobileSum > 0 || coinsMobileSum > 0 else {
            throw NSError(domain: "createMobilePayment", code: 2, userInfo: [NSLocalizedDescriptionKey: "Мобильный платеж не может быть 0."])
        }
        
        // Создаем сумму мобильным платежом с использованием структуры Money
        let money = Money()
        try payment.sum = money.createMoney(bills: billsMobileSum, coins: coinsMobileSum)
        
        return payment
    }
}
