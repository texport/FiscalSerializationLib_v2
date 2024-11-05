//
//  AmountsTests.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 05.11.2024.
//

import XCTest
@testable import FiscalSerializationLib_v2

final class AmountsTests: XCTestCase {
    
    var amounts: Amounts!
    
    // MARK: - Setup/Teardown
    
    override func setUp() {
        super.setUp()
        amounts = Amounts()
    }
    
    override func tearDown() {
        amounts = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    /// Проверяет, что метод `createAmounts` правильно рассчитывает сдачу, если сдача должна быть только в купюрах.
    func testCreateAmounts_WithChangeInBillsOnly_ShouldReturnCorrectChange() {
        do {
            let payments = try Payments(
                isCash: true, billsCashSum: 1000, coinsCashSum: 0,
                isCard: false, billsCardSum: nil, coinsCardSum: nil,
                isMobile: false, billsMobileSum: nil, coinsMobileSum: nil
            ).createPayments()
            
            let total = try Money().createMoney(bills: 900, coins: 0)
            let taken = try Money().createMoney(bills: 1000, coins: 0)
            
            let result = try amounts.createAmounts(payments: payments, total: total, taken: taken, discount: nil)
            
            XCTAssertNotNil(result.change, "Сдача должна быть рассчитана и не равна nil.")
            XCTAssertEqual(result.change.bills, 100, "Сдача в купюрах должна быть 100.")
            XCTAssertEqual(result.change.coins, 0, "Сдача в монетах должна быть 0.")
        } catch {
            XCTFail("Не удалось создать объект Payments или Money: \(error)")
        }
    }
    
    /// Проверяет, что метод `createAmounts` правильно рассчитывает сдачу, если сдача должна быть только в монетах.
    func testCreateAmounts_WithChangeInCoinsOnly_ShouldReturnCorrectChange() {
        do {
            let payments = try Payments(
                isCash: true, billsCashSum: 1000, coinsCashSum: 50,
                isCard: false, billsCardSum: nil, coinsCardSum: nil,
                isMobile: false, billsMobileSum: nil, coinsMobileSum: nil
            ).createPayments()
            
            let total = try Money().createMoney(bills: 1000, coins: 25)
            let taken = try Money().createMoney(bills: 1000, coins: 50)
            
            let result = try amounts.createAmounts(payments: payments, total: total, taken: taken, discount: nil)
            
            XCTAssertNotNil(result.change, "Сдача должна быть рассчитана и не равна nil.")
            XCTAssertEqual(result.change.bills, 0, "Сдача в купюрах должна быть 0.")
            XCTAssertEqual(result.change.coins, 25, "Сдача в монетах должна быть 25.")
        } catch {
            XCTFail("Не удалось создать объект Payments или Money: \(error)")
        }
    }
    
    /// Проверяет, что метод `createAmounts` правильно рассчитывает сдачу, если монет недостаточно и требуется пересчет в купюры.
    func testCreateAmounts_WithInsufficientCoins_ShouldReturnCorrectChange() {
        do {
            let payments = try Payments(
                isCash: true, billsCashSum: 1010, coinsCashSum: 0,
                isCard: false, billsCardSum: nil, coinsCardSum: nil,
                isMobile: false, billsMobileSum: nil, coinsMobileSum: nil
            ).createPayments()
            
            let total = try Money().createMoney(bills: 1000, coins: 75)
            let taken = try Money().createMoney(bills: 1010, coins: 0)
            
            let result = try amounts.createAmounts(payments: payments, total: total, taken: taken, discount: nil)
            
            XCTAssertNotNil(result.change, "Сдача должна быть рассчитана и не равна nil.")
            XCTAssertEqual(result.change.bills, 9, "Сдача в купюрах должна быть 9.")
            XCTAssertEqual(result.change.coins, 25, "Сдача в монетах должна быть 25.")
        } catch {
            XCTFail("Не удалось создать объект Payments или Money: \(error)")
        }
    }
    
    /// Проверяет, что метод `createAmounts` корректно обрабатывает отсутствие сдачи при точной оплате.
    func testCreateAmounts_WithExactPayment_ShouldReturnNoChange() {
        do {
            let payments = try Payments(
                isCash: true, billsCashSum: 1000, coinsCashSum: 50,
                isCard: false, billsCardSum: nil, coinsCardSum: nil,
                isMobile: false, billsMobileSum: nil, coinsMobileSum: nil
            ).createPayments()
            
            let total = try Money().createMoney(bills: 1000, coins: 50)
            let taken = try Money().createMoney(bills: 1000, coins: 50)
            
            let result = try amounts.createAmounts(payments: payments, total: total, taken: taken, discount: nil)
            
            XCTAssertEqual(result.change.bills, 0, "Сдача в купюрах должна быть 0.")
            XCTAssertEqual(result.change.coins, 0, "Сдача в монетах должна быть 0.")
        } catch {
            XCTFail("Не удалось создать объект Payments или Money: \(error)")
        }
    }
}
