//
//  Payments.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 01.11.2024.
//

import Foundation

/// Структура `PaymentBuilder` для создания массива платежей с разными типами оплаты
struct Payments {
    private let isCash: Bool
    private let billsCashSum: UInt64?
    private let coinsCashSum: UInt32?
    
    private let isCard: Bool
    private let billsCardSum: UInt64?
    private let coinsCardSum: UInt32?
    
    private let isMobile: Bool
    private let billsMobileSum: UInt64?
    private let coinsMobileSum: UInt32?
    
    /// Инициализатор для создания объекта `Payments`
    /// - Parameters:
    ///   - isCash: Флаг, указывающий, что используется наличный платеж
    ///   - isCard: Флаг, указывающий, что используется платеж картой
    ///   - isMobile: Флаг, указывающий, что используется мобильный платеж
    init(isCash: Bool, billsCashSum: UInt64?, coinsCashSum: UInt32?,
         isCard: Bool, billsCardSum: UInt64?, coinsCardSum: UInt32?,
         isMobile: Bool, billsMobileSum: UInt64?, coinsMobileSum: UInt32?) {
        self.isCash = isCash
        self.billsCashSum = billsCashSum
        self.coinsCashSum = coinsCashSum
        
        self.isCard = isCard
        self.billsCardSum = billsCardSum
        self.coinsCardSum = coinsCardSum
        
        self.isMobile = isMobile
        self.billsMobileSum = billsMobileSum
        self.coinsMobileSum = coinsMobileSum
    }
    
    /// Метод для создания массива платежей в зависимости от типа оплаты
    /// - Throws: Генерирует ошибку, если не указан ни один способ оплаты
    /// - Returns: Массив объектов `Kkm_Proto_TicketRequest.Payment`
    func createPayments() throws -> [Kkm_Proto_TicketRequest.Payment] {
        // Проверка: хотя бы один из типов оплаты должен быть установлен и равен true
        guard isCard || isCash || isMobile else {
            throw NSError(domain: "createPayments", code: 1, userInfo: [NSLocalizedDescriptionKey: "Должен быть указан хотя бы один способ оплаты (наличные, карта или мобильный платеж)."])
        }
        
        var payments: [Kkm_Proto_TicketRequest.Payment] = []
        
        // Валидация отсутствующих данных для каждого типа оплаты, если они не используются
        try validatePaymentDetails(isEnabled: isCash, billsSum: billsCashSum, coinsSum: coinsCashSum, paymentType: "наличными")
        try validatePaymentDetails(isEnabled: isCard, billsSum: billsCardSum, coinsSum: coinsCardSum, paymentType: "картой")
        try validatePaymentDetails(isEnabled: isMobile, billsSum: billsMobileSum, coinsSum: coinsMobileSum, paymentType: "мобильным платежом")
        
        // Создание платежей в зависимости от выбранного типа оплаты
        if isCash {
            let cashPayment = try CashPayment(billsCashSum: billsCashSum, coinsCashSum: coinsCashSum).createCashPayment()
            payments.append(cashPayment)
        }
        
        if isCard {
            let cardPayment = try CardPayment(billsCardSum: billsCardSum, coinsCardSum: coinsCardSum).createCardPayment()
            payments.append(cardPayment)
        }
        
        if isMobile {
            let mobilePayment = try MobilePayment(billsMobileSum: billsMobileSum, coinsMobileSum: coinsMobileSum).createMobilePayment()
            payments.append(mobilePayment)
        }
        
        return payments
    }
    
    // Вспомогательный метод для валидации данных оплаты
    private func validatePaymentDetails(isEnabled: Bool, billsSum: UInt64?, coinsSum: UInt32?, paymentType: String) throws {
        if !isEnabled {
            guard billsSum == nil, coinsSum == nil else {
                throw NSError(domain: "createPayments", code: 2, userInfo: [NSLocalizedDescriptionKey: "Если расчет не \(paymentType), то данные по \(paymentType) должны быть nil."])
            }
        }
    }
}
