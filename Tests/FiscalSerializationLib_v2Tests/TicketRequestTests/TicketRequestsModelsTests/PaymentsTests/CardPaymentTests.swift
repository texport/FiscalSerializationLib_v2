//
//  CardPaymentTests.swift
//  FiscalSerializationLib_v2Tests
//
//  Created by Sergey Ivanov on 01.11.2024.
//

import XCTest
@testable import FiscalSerializationLib_v2

/// Класс тестов для проверки корректной работы структуры `CardPayment`
final class CardPaymentTests: XCTestCase {
    var cardPayment: CardPayment!
    
    /// Метод настройки перед каждым тестом
    override func setUp() {
        super.setUp()
        // Настройка объекта перед каждым тестом
        cardPayment = CardPayment(billsCardSum: 1000, coinsCardSum: 50)
    }
    
    /// Метод очистки после каждого теста
    override func tearDown() {
        // Очистка объекта после каждого теста
        cardPayment = nil
        super.tearDown()
    }
    
    // MARK: - Тесты для createCardPayment
    
    /// Тест для проверки успешного создания платежа картой
    func testCreateCardPayment_Success() throws {
        let payment = try cardPayment.createCardPayment()
        
        XCTAssertEqual(payment.type, Kkm_Proto_PaymentTypeEnum.paymentCard, "Тип оплаты должен быть paymentCard")
        XCTAssertNotNil(payment.sum, "Сумма оплаты картой должна быть создана")
        XCTAssertEqual(payment.sum.bills, 1000, "Неверная сумма в целых единицах")
        XCTAssertEqual(payment.sum.coins, 50, "Неверная сумма в дробных единицах")
    }
    
    /// Тест для проверки выброса ошибки при отсутствии суммы оплаты картой
    func testCreateCardPayment_MissingSum_ThrowsError() {
        // Создаем объект с отсутствующими суммами
        cardPayment = CardPayment(billsCardSum: nil, coinsCardSum: nil)
        
        XCTAssertThrowsError(try cardPayment.createCardPayment()) { error in
            let nsError = error as NSError
            XCTAssertEqual(nsError.domain, "createCardPayment", "Неверный домен ошибки")
            XCTAssertEqual(nsError.code, 1, "Ожидается ошибка с кодом 1 при отсутствии суммы оплаты картой")
        }
    }
    
    /// Тест для проверки выброса ошибки при сумме, равной нулю
    func testCreateCardPayment_ZeroSum_ThrowsError() {
        // Создаем объект с нулевыми суммами
        cardPayment = CardPayment(billsCardSum: 0, coinsCardSum: 0)
        
        XCTAssertThrowsError(try cardPayment.createCardPayment()) { error in
            let nsError = error as NSError
            XCTAssertEqual(nsError.domain, "createCardPayment", "Неверный домен ошибки")
            XCTAssertEqual(nsError.code, 2, "Ожидается ошибка с кодом 2 при сумме оплаты картой, равной нулю")
        }
    }
    
    /// Тест для проверки успешного создания платежа картой с минимальными ненулевыми значениями
    func testCreateCardPayment_MinNonZeroSum_Success() throws {
        // Создаем объект с минимальными ненулевыми значениями
        cardPayment = CardPayment(billsCardSum: 1, coinsCardSum: 1)
        let payment = try cardPayment.createCardPayment()
        
        XCTAssertEqual(payment.sum.bills, 1, "Неверная сумма в целых единицах")
        XCTAssertEqual(payment.sum.coins, 1, "Неверная сумма в дробных единицах")
    }
    
    /// Тест для проверки выброса ошибки при отсутствии одной из сумм (целой или дробной)
    func testCreateCardPayment_MissingOnePartOfSum_ThrowsError() {
        // Создаем объект с отсутствующей целой частью суммы
        cardPayment = CardPayment(billsCardSum: nil, coinsCardSum: 50)
        XCTAssertThrowsError(try cardPayment.createCardPayment()) { error in
            let nsError = error as NSError
            XCTAssertEqual(nsError.domain, "createCardPayment", "Неверный домен ошибки")
            XCTAssertEqual(nsError.code, 1, "Ожидается ошибка с кодом 1 при отсутствии целой части суммы оплаты картой")
        }
        
        // Создаем объект с отсутствующей дробной частью суммы
        cardPayment = CardPayment(billsCardSum: 1000, coinsCardSum: nil)
        XCTAssertThrowsError(try cardPayment.createCardPayment()) { error in
            let nsError = error as NSError
            XCTAssertEqual(nsError.domain, "createCardPayment", "Неверный домен ошибки")
            XCTAssertEqual(nsError.code, 1, "Ожидается ошибка с кодом 1 при отсутствии дробной части суммы оплаты картой")
        }
    }
}
