//
//  MobilePaymentTests.swift
//  FiscalSerializationLib_v2Tests
//
//  Created by Sergey Ivanov on 01.11.2024.
//

import XCTest
@testable import FiscalSerializationLib_v2

/// Класс тестов для проверки корректной работы структуры `MobilePayment`
final class MobilePaymentTests: XCTestCase {
    var mobilePayment: MobilePayment!
    
    /// Метод настройки перед каждым тестом
    override func setUp() {
        super.setUp()
        // Настройка объекта перед каждым тестом
        mobilePayment = MobilePayment(billsMobileSum: 1000, coinsMobileSum: 50)
    }
    
    /// Метод очистки после каждого теста
    override func tearDown() {
        // Очистка объекта после каждого теста
        mobilePayment = nil
        super.tearDown()
    }
    
    // MARK: - Тесты для createMobilePayment
    
    /// Тест для проверки успешного создания мобильного платежа
    func testCreateMobilePayment_Success() throws {
        let payment = try mobilePayment.createMobilePayment()
        
        XCTAssertEqual(payment.type, Kkm_Proto_PaymentTypeEnum.paymentMobile, "Тип оплаты должен быть paymentMobile")
        XCTAssertNotNil(payment.sum, "Сумма мобильного платежа должна быть создана")
        XCTAssertEqual(payment.sum.bills, 1000, "Неверная сумма в целых единицах")
        XCTAssertEqual(payment.sum.coins, 50, "Неверная сумма в дробных единицах")
    }
    
    /// Тест для проверки выброса ошибки при отсутствии суммы мобильного платежа
    func testCreateMobilePayment_MissingSum_ThrowsError() {
        // Создаем объект с отсутствующими суммами
        mobilePayment = MobilePayment(billsMobileSum: nil, coinsMobileSum: nil)
        
        XCTAssertThrowsError(try mobilePayment.createMobilePayment()) { error in
            let nsError = error as NSError
            XCTAssertEqual(nsError.domain, "createMobilePayment", "Неверный домен ошибки")
            XCTAssertEqual(nsError.code, 1, "Ожидается ошибка с кодом 1 при отсутствии суммы мобильного платежа")
        }
    }
    
    /// Тест для проверки выброса ошибки при сумме, равной нулю
    func testCreateMobilePayment_ZeroSum_ThrowsError() {
        // Создаем объект с нулевыми суммами
        mobilePayment = MobilePayment(billsMobileSum: 0, coinsMobileSum: 0)
        
        XCTAssertThrowsError(try mobilePayment.createMobilePayment()) { error in
            let nsError = error as NSError
            XCTAssertEqual(nsError.domain, "createMobilePayment", "Неверный домен ошибки")
            XCTAssertEqual(nsError.code, 2, "Ожидается ошибка с кодом 2 при сумме мобильного платежа равной нулю")
        }
    }
    
    /// Тест для проверки успешного создания мобильного платежа с минимальными ненулевыми значениями
    func testCreateMobilePayment_MinNonZeroSum_Success() throws {
        // Создаем объект с минимальными ненулевыми значениями
        mobilePayment = MobilePayment(billsMobileSum: 1, coinsMobileSum: 1)
        let payment = try mobilePayment.createMobilePayment()
        
        XCTAssertEqual(payment.sum.bills, 1, "Неверная сумма в целых единицах")
        XCTAssertEqual(payment.sum.coins, 1, "Неверная сумма в дробных единицах")
    }
    
    /// Тест для проверки выброса ошибки при сумме мобильного платежа с нулевыми купюрами и монетами
    func testCreateMobilePayment_ZeroBillsAndCoins_ThrowsError() {
        // Создаем объект с нулевыми значениями купюр и монет
        mobilePayment = MobilePayment(billsMobileSum: 0, coinsMobileSum: 0)
        
        XCTAssertThrowsError(try mobilePayment.createMobilePayment()) { error in
            let nsError = error as NSError
            XCTAssertEqual(nsError.domain, "createMobilePayment", "Неверный домен ошибки")
            XCTAssertEqual(nsError.code, 2, "Ожидается ошибка с кодом 2 при нулевых купюрах и монетах")
        }
    }
}
