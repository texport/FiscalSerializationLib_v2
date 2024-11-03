//
//  MoneyTests.swift
//  FiscalSerializationLib_v2Tests
//
//  Created by Sergey Ivanov on 01.11.2024.
//

import XCTest
@testable import FiscalSerializationLib_v2

/// Класс тестов для проверки корректной работы структуры Money
final class MoneyTests: XCTestCase {
    var money: Money!

    /// Метод настройки перед каждым тестом
    override func setUp() {
        super.setUp()
        money = Money()
    }

    /// Метод очистки после каждого теста
    override func tearDown() {
        money = nil
        super.tearDown()
    }

    // MARK: - Тесты для createMoney

    /// Тест для проверки корректного создания объекта Kkm_Proto_Money с нулевыми значениями
    func testCreateMoney_ValidZeroValues() throws {
        let protoMoney = try money.createMoney(bills: 0, coins: 0)
        
        XCTAssertEqual(protoMoney.bills, 0)
        XCTAssertEqual(protoMoney.coins, 0)
    }
    
    /// Тест для проверки корректного создания объекта Kkm_Proto_Money с максимальными допустимыми значениями coins
    func testCreateMoney_ValidMaxCoins() throws {
        let protoMoney = try money.createMoney(bills: 1000, coins: 99)
        
        XCTAssertEqual(protoMoney.bills, 1000)
        XCTAssertEqual(protoMoney.coins, 99)
    }
    
    /// Тест для проверки корректного создания объекта Kkm_Proto_Money с нулевым значением coins и положительным значением bills
    func testCreateMoney_ValidZeroCoins() throws {
        let protoMoney = try money.createMoney(bills: 1000, coins: 0)
        
        XCTAssertEqual(protoMoney.bills, 1000)
        XCTAssertEqual(protoMoney.coins, 0)
    }
    
    /// Тест для проверки корректного создания объекта Kkm_Proto_Money с положительным значением coins и нулевым значением bills
    func testCreateMoney_ValidZeroBills() throws {
        let protoMoney = try money.createMoney(bills: 0, coins: 50)
        
        XCTAssertEqual(protoMoney.bills, 0)
        XCTAssertEqual(protoMoney.coins, 50)
    }
    
    /// Тест для проверки выброса ошибки при недопустимом значении coins (100 и более)
    func testCreateMoney_InvalidCoins() {
        XCTAssertThrowsError(try money.createMoney(bills: 1000, coins: 100)) { error in
            XCTAssertEqual((error as NSError).domain, "createMoney")
            XCTAssertEqual((error as NSError).code, 1)
        }
        
        XCTAssertThrowsError(try money.createMoney(bills: 0, coins: 150)) { error in
            XCTAssertEqual((error as NSError).domain, "createMoney")
            XCTAssertEqual((error as NSError).code, 1)
        }
    }
    
    /// Тест для проверки корректного создания объекта Kkm_Proto_Money с минимальными допустимыми значениями
    func testCreateMoney_MinValues() throws {
        let protoMoney = try money.createMoney(bills: 0, coins: 1)
        
        XCTAssertEqual(protoMoney.bills, 0)
        XCTAssertEqual(protoMoney.coins, 1)
    }
    
    /// Тест для проверки корректного создания объекта Kkm_Proto_Money с максимальным значением bills и минимальным значением coins
    func testCreateMoney_MaxBillsMinCoins() throws {
        let protoMoney = try money.createMoney(bills: UInt64.max, coins: 0)
        
        XCTAssertEqual(protoMoney.bills, UInt64.max)
        XCTAssertEqual(protoMoney.coins, 0)
    }
}
