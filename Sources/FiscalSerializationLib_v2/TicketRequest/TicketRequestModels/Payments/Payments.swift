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
        guard (isCard) || (isCash) || (isMobile) else {
            throw NSError(domain: "createPayments", code: 1, userInfo: [NSLocalizedDescriptionKey: "Должен быть указан хотя бы один способ оплаты (наличные, карта или мобильный платеж)."])
        }
        
        var payments: [Kkm_Proto_TicketRequest.Payment] = []
        
        // Если расчет не наличными, проверяем, что данные по наличным платежам отсутствуют
        if !isCash {
            guard billsCashSum == nil, coinsCashSum == nil else {
                throw NSError(domain: "createPayments", code: 2, userInfo: [NSLocalizedDescriptionKey: "Если расчет не наличными, то данные по наличным платежам должны быть nil."])
            }
            // Ошибка, если данные по наличным присутствуют, но расчет не наличными
            throw NSError(domain: "createPayments", code: 3, userInfo: [NSLocalizedDescriptionKey: "Данные по наличным платежам указаны, но расчет не наличными."])
        }
        
        // Создание платежа наличными, если он используется
        if isCash {
            let cashPayment = try CashPayment(billsCashSum: billsCashSum, coinsCashSum: coinsCashSum).createCashPayment()
            payments.append(cashPayment)
        }
        
        // Если расчет не картой, проверяем, что данные по картам отсутствуют
        if !isCard {
            guard billsCardSum == nil, coinsCardSum == nil else {
                throw NSError(domain: "createPayments", code: 4, userInfo: [NSLocalizedDescriptionKey: "Если расчет не картой, то данные по картам должны быть nil."])
            }
            // Ошибка, если данные по картам присутствуют, но расчет не картой
            throw NSError(domain: "createPayments", code: 5, userInfo: [NSLocalizedDescriptionKey: "Данные по оплате картой указаны, но расчет не картой."])
        }
        
        // Создание платежа картой, если он используется
        if isCard {
            let cardPayment = try CardPayment(billsCardSum: billsCardSum, coinsCardSum: coinsCardSum).createCardPayment()
            payments.append(cardPayment)
        }
        
        // Если расчет не мобильным платежом, проверяем, что данные по мобильным платежам отсутствуют
        if !isMobile {
            guard billsMobileSum == nil, coinsMobileSum == nil else {
                throw NSError(domain: "PaymentError", code: 10, userInfo: [NSLocalizedDescriptionKey: "Если расчет не мобильным платежом, то данные по мобильным платежам должны быть nil."])
            }
            // Ошибка, если данные по мобильным платежам присутствуют, но расчет не мобильным
            throw NSError(domain: "PaymentError", code: 11, userInfo: [NSLocalizedDescriptionKey: "Данные по мобильному платежу указаны, но расчет не мобильным."])
        }
        
        // Создание мобильного платежа, если он используется
        if isMobile {
            let mobilePayment = try MobilePayment(billsMobileSum: billsMobileSum, coinsMobileSum: coinsMobileSum).createMobilePayment()
            payments.append(mobilePayment)
        }
        
        return payments
    }
}
