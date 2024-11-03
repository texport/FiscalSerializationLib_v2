//
//  CashPaymentTests.swift
//  FiscalSerializationLib_v2Tests
//
//  Created by Sergey Ivanov on 01.11.2024.
//

import XCTest
@testable import FiscalSerializationLib_v2

/// Класс тестов для проверки корректной работы структуры `CashPayment`
final class CashPaymentTests: XCTestCase {
    var cashPayment: CashPayment!
    
    /// Метод настройки перед каждым тестом
    override func setUp() {
        super.setUp()
        // Настройка объекта перед каждым тестом
        cashPayment = CashPayment(billsCashSum: 1000, coinsCashSum: 50)
    }
    
    /// Метод очистки после каждого теста
    override func tearDown() {
        // Очистка объекта после каждого теста
        cashPayment = nil
        super.tearDown()
    }
    
    // MARK: - Тесты для createCashPayment
    
    /// Тест для проверки успешного создания платежа наличными
    func testCreateCashPayment_Success() throws {
        let payment = try cashPayment.createCashPayment()
        
        XCTAssertEqual(payment.type, Kkm_Proto_PaymentTypeEnum.paymentCash, "Тип оплаты должен быть paymentCash")
        XCTAssertNotNil(payment.sum, "Сумма оплаты наличными должна быть создана")
        XCTAssertEqual(payment.sum.bills, 1000, "Неверная сумма в целых единицах")
        XCTAssertEqual(payment.sum.coins, 50, "Неверная сумма в дробных единицах")
    }
    
    /// Тест для проверки выброса ошибки при отсутствии суммы оплаты наличными
    func testCreateCashPayment_MissingSum_ThrowsError() {
        // Создаем объект с отсутствующими суммами
        cashPayment = CashPayment(billsCashSum: nil, coinsCashSum: nil)
        
        XCTAssertThrowsError(try cashPayment.createCashPayment()) { error in
            let nsError = error as NSError
            XCTAssertEqual(nsError.domain, "createCashPayment", "Неверный домен ошибки")
            XCTAssertEqual(nsError.code, 1, "Ожидается ошибка с кодом 4 при отсутствии суммы оплаты наличными")
        }
    }
    
    /// Тест для проверки успешного создания платежа наличными с минимальными ненулевыми значениями
    func testCreateCashPayment_MinNonZeroSum_Success() throws {
        // Создаем объект с минимальными ненулевыми значениями
        cashPayment = CashPayment(billsCashSum: 1, coinsCashSum: 1)
        let payment = try cashPayment.createCashPayment()
        
        XCTAssertEqual(payment.sum.bills, 1, "Неверная сумма в целых единицах")
        XCTAssertEqual(payment.sum.coins, 1, "Неверная сумма в дробных единицах")
    }
}
