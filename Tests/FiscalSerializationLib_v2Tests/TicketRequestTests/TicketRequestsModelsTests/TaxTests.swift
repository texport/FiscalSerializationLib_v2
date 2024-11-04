//
//  TaxTests.swift
//  FiscalSerializationLib_v2Tests
//
//  Created by Sergey Ivanov on 01.11.2024.
//

import XCTest
@testable import FiscalSerializationLib_v2

/// Класс тестов для проверки корректной работы структуры Tax
final class TaxTests: XCTestCase {
    var tax: Tax!
    
    /// Метод настройки перед каждым тестом
    override func setUp() {
        super.setUp()
        tax = Tax()
    }
    
    /// Метод очистки после каждого теста
    override func tearDown() {
        tax = nil
        super.tearDown()
    }
    
    // MARK: - Тесты для createTax
    
    /// Тест для создания налога с корректным процентом 0% и нулевой суммой
    func testCreateTax_ZeroPercentAndZeroSum() throws {
        let sum = Kkm_Proto_Money.with {
            $0.bills = 0
            $0.coins = 0
        }
        let taxes = try tax.createTax(percent: 0, sum: sum)
        
        XCTAssertEqual(taxes.count, 1)
        XCTAssertEqual(taxes[0].percent, 0)
        XCTAssertEqual(taxes[0].sum.bills, 0)
        XCTAssertEqual(taxes[0].sum.coins, 0)
        XCTAssertTrue(taxes[0].isInTotalSum)
    }
    
    /// Тест для создания налога с корректным процентом 12% и ненулевой суммой
    func testCreateTax_TwelvePercentAndNonZeroSum() throws {
        let sum = Kkm_Proto_Money.with {
            $0.bills = 1000
            $0.coins = 50
        }
        let taxes = try tax.createTax(percent: 12000, sum: sum)
        
        XCTAssertEqual(taxes.count, 1)
        XCTAssertEqual(taxes[0].percent, 12000)
        XCTAssertEqual(taxes[0].sum.bills, 1000)
        XCTAssertEqual(taxes[0].sum.coins, 50)
        XCTAssertTrue(taxes[0].isInTotalSum)
    }
    
    /// Тест для проверки выброса ошибки при некорректном проценте налога
    func testCreateTax_InvalidPercent() {
        let sum = Kkm_Proto_Money.with {
            $0.bills = 1000
            $0.coins = 0
        }
        XCTAssertThrowsError(try tax.createTax(percent: 5000, sum: sum)) { error in
            XCTAssertEqual((error as NSError).domain, "createTax")
            XCTAssertEqual((error as NSError).code, 1)
        }
    }
    
    /// Тест для проверки выброса ошибки, если сумма не соответствует проценту 0%
    func testCreateTax_ZeroPercentWithNonZeroSum() {
        let sum = Kkm_Proto_Money.with {
            $0.bills = 1000
            $0.coins = 0
        }
        XCTAssertThrowsError(try tax.createTax(percent: 0, sum: sum)) { error in
            XCTAssertEqual((error as NSError).domain, "createTax")
            XCTAssertEqual((error as NSError).code, 2)
        }
    }
    
    /// Тест для проверки выброса ошибки, если сумма равна нулю при проценте 12%
    func testCreateTax_TwelvePercentWithZeroSum() {
        let sum = Kkm_Proto_Money.with {
            $0.bills = 0
            $0.coins = 0
        }
        XCTAssertThrowsError(try tax.createTax(percent: 12000, sum: sum)) { error in
            XCTAssertEqual((error as NSError).domain, "createTax")
            XCTAssertEqual((error as NSError).code, 2)
        }
    }
    
    // MARK: - Тесты для checkSum
    
    /// Тест для проверки, что метод checkSum возвращает true при ненулевой сумме
    func testCheckSum_NonZeroSum() {
        let sum = Kkm_Proto_Money.with {
            $0.bills = 1000
            $0.coins = 50
        }
        XCTAssertTrue(tax.checkSum(money: sum))
    }
    
    /// Тест для проверки, что метод checkSum возвращает false при нулевой сумме
    func testCheckSum_ZeroSum() {
        let sum = Kkm_Proto_Money.with {
            $0.bills = 0
            $0.coins = 0
        }
        XCTAssertFalse(tax.checkSum(money: sum))
    }
    
    /// Тест для проверки, что метод checkSum возвращает true при ненулевых монетах
    func testCheckSum_NonZeroCoinsOnly() {
        let sum = Kkm_Proto_Money.with {
            $0.bills = 0
            $0.coins = 50
        }
        XCTAssertTrue(tax.checkSum(money: sum))
    }
    
    /// Тест для проверки, что метод checkSum возвращает true при ненулевых купюрах
    func testCheckSum_NonZeroBillsOnly() {
        let sum = Kkm_Proto_Money.with {
            $0.bills = 1000
            $0.coins = 0
        }
        XCTAssertTrue(tax.checkSum(money: sum))
    }
}
