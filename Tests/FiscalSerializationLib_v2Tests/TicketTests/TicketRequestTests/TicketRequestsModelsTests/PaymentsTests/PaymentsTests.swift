//
//  PaymentsTests.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 04.11.2024.
//

import XCTest
@testable import FiscalSerializationLib_v2

/// Класс тестов для структуры `Payments`
final class PaymentsTests: XCTestCase {
    
    // MARK: - Тесты для createPayments
    
    /// Тест для проверки успешного создания всех типов платежей
    func testCreatePayments_AllPayments_Success() throws {
        let payments = Payments(isCash: true, billsCashSum: 1000, coinsCashSum: 50,
                                isCard: true, billsCardSum: 2000, coinsCardSum: 75,
                                isMobile: true, billsMobileSum: 1500, coinsMobileSum: 25)
        let result = try payments.createPayments()
        
        XCTAssertEqual(result.count, 3, "Должно быть создано три платежа")
    }
    
    /// Тест для проверки успешного создания только наличного платежа
    func testCreatePayments_CashOnly_Success() throws {
        let payments = Payments(isCash: true, billsCashSum: 1000, coinsCashSum: 50,
                                isCard: false, billsCardSum: nil, coinsCardSum: nil,
                                isMobile: false, billsMobileSum: nil, coinsMobileSum: nil)
        let result = try payments.createPayments()
        
        XCTAssertEqual(result.count, 1, "Должен быть создан только один наличный платеж")
        XCTAssertEqual(result.first?.type, Kkm_Proto_PaymentTypeEnum.paymentCash, "Тип оплаты должен быть paymentCash")
    }
    
    /// Тест для проверки успешного создания только платежа картой
    func testCreatePayments_CardOnly_Success() throws {
        let payments = Payments(isCash: false, billsCashSum: nil, coinsCashSum: nil,
                                isCard: true, billsCardSum: 2000, coinsCardSum: 75,
                                isMobile: false, billsMobileSum: nil, coinsMobileSum: nil)
        let result = try payments.createPayments()
        
        XCTAssertEqual(result.count, 1, "Должен быть создан только один платеж картой")
        XCTAssertEqual(result.first?.type, Kkm_Proto_PaymentTypeEnum.paymentCard, "Тип оплаты должен быть paymentCard")
    }
    
    /// Тест для проверки успешного создания только мобильного платежа
    func testCreatePayments_MobileOnly_Success() throws {
        let payments = Payments(isCash: false, billsCashSum: nil, coinsCashSum: nil,
                                isCard: false, billsCardSum: nil, coinsCardSum: nil,
                                isMobile: true, billsMobileSum: 1500, coinsMobileSum: 25)
        let result = try payments.createPayments()
        
        XCTAssertEqual(result.count, 1, "Должен быть создан только один мобильный платеж")
        XCTAssertEqual(result.first?.type, Kkm_Proto_PaymentTypeEnum.paymentMobile, "Тип оплаты должен быть paymentMobile")
    }
    
    /// Тест для проверки выброса ошибки при отсутствии всех типов платежей
    func testCreatePayments_NoPayment_ThrowsError() {
        let payments = Payments(isCash: false, billsCashSum: nil, coinsCashSum: nil,
                                isCard: false, billsCardSum: nil, coinsCardSum: nil,
                                isMobile: false, billsMobileSum: nil, coinsMobileSum: nil)
        
        XCTAssertThrowsError(try payments.createPayments()) { error in
            let nsError = error as NSError
            XCTAssertEqual(nsError.domain, "createPayments", "Домен ошибки должен быть createPayments")
            XCTAssertEqual(nsError.code, 1, "Код ошибки должен быть 1 при отсутствии всех типов платежей")
        }
    }
    
    /// Тест для проверки выброса ошибки при наличии данных по наличным платежам, когда флаг isCash равен false
    func testCreatePayments_CashDataWhenIsCashFalse_ThrowsError() {
        let payments = Payments(isCash: false, billsCashSum: 1000, coinsCashSum: 50,
                                isCard: true, billsCardSum: 2000, coinsCardSum: 75,
                                isMobile: false, billsMobileSum: nil, coinsMobileSum: nil)
        
        XCTAssertThrowsError(try payments.createPayments()) { error in
            let nsError = error as NSError
            XCTAssertEqual(nsError.domain, "createPayments", "Домен ошибки должен быть createPayments")
            XCTAssertEqual(nsError.code, 2, "Код ошибки должен быть 2 при указанных данных по наличным платежам, когда isCash равен false")
        }
    }
        
    /// Тест для проверки выброса ошибки при наличии данных по оплате картой, когда флаг isCard равен false
    func testCreatePayments_CardDataWhenIsCardFalse_ThrowsError() {
        let payments = Payments(isCash: true, billsCashSum: 1000, coinsCashSum: 50,
                                isCard: false, billsCardSum: 2000, coinsCardSum: 75,
                                isMobile: false, billsMobileSum: nil, coinsMobileSum: nil)
        
        XCTAssertThrowsError(try payments.createPayments()) { error in
            let nsError = error as NSError
            XCTAssertEqual(nsError.domain, "createPayments", "Домен ошибки должен быть createPayments")
            XCTAssertEqual(nsError.code, 2, "Код ошибки должен быть 2 при указанных данных по оплате картой, когда isCard равен false")
        }
    }
        
    /// Тест для проверки выброса ошибки при наличии данных по мобильному платежу, когда флаг isMobile равен false
    func testCreatePayments_MobileDataWhenIsMobileFalse_ThrowsError() {
        let payments = Payments(isCash: true, billsCashSum: 1000, coinsCashSum: 50,
                                isCard: false, billsCardSum: nil, coinsCardSum: nil,
                                isMobile: false, billsMobileSum: 1500, coinsMobileSum: 25)
        
        XCTAssertThrowsError(try payments.createPayments()) { error in
            let nsError = error as NSError
            XCTAssertEqual(nsError.domain, "createPayments", "Домен ошибки должен быть createPayments")
            XCTAssertEqual(nsError.code, 2, "Код ошибки должен быть 2 при указанных данных по мобильному платежу, когда isMobile равен false")
        }
    }
}

