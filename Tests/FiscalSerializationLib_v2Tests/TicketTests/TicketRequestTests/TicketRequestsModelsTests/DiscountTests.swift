//
//  DiscountTests.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 04.11.2024.
//

import XCTest
@testable import FiscalSerializationLib_v2

/// Класс тестов для структуры `Discount`
///
/// Тестирует создание модификаторов скидок и проверяет валидацию имени и суммы.
final class DiscountTests: XCTestCase {
    /// Тест для успешного создания модификатора скидки с корректными данными.
    ///
    /// Проверяет, что модификатор создается корректно, если все параметры валидны.
    func testCreateDiscountModifier_Success() throws {
        let discount = Discount()
        let sum = try Money().createMoney(bills: 1000, coins: 50)
        let modifier = try discount.createDicountModifier(name: "Скидка 10%", sum: sum)
        
        XCTAssertEqual(modifier.name, "Скидка 10%", "Имя модификатора должно совпадать с введенным.")
        XCTAssertEqual(modifier.sum, sum, "Сумма модификатора должна совпадать с введенной.")
    }
    
    /// Тест для проверки ошибки при пустом имени.
    ///
    /// Проверяет, что выбрасывается ошибка, если имя модификатора пустое.
    func testCreateDiscountModifier_EmptyName_ThrowsError() {
        let discount = Discount()
        let sum: Kkm_Proto_Money
        do {
            sum = try Money().createMoney(bills: 1000, coins: 50)
        } catch {
            XCTFail("Ошибка при создании Money: \(error)")
            return
        }
        
        XCTAssertThrowsError(try discount.createDicountModifier(name: "", sum: sum)) { error in
            let nsError = error as NSError
            XCTAssertEqual(nsError.domain, "validateNameDiscount", "Домен ошибки должен быть validateNameDiscount.")
            XCTAssertEqual(nsError.code, 1, "Код ошибки должен быть 1 при пустом имени.")
        }
    }
    
    /// Тест для проверки ошибки при имени, состоящем только из пробелов.
    ///
    /// Проверяет, что выбрасывается ошибка, если имя модификатора состоит только из пробелов.
    func testCreateDiscountModifier_WhitespaceName_ThrowsError() {
        let discount = Discount()
        let sum: Kkm_Proto_Money
        do {
            sum = try Money().createMoney(bills: 1000, coins: 50)
        } catch {
            XCTFail("Ошибка при создании Money: \(error)")
            return
        }
        
        XCTAssertThrowsError(try discount.createDicountModifier(name: "   ", sum: sum)) { error in
            let nsError = error as NSError
            XCTAssertEqual(nsError.domain, "validateNameDiscount", "Домен ошибки должен быть validateNameDiscount.")
            XCTAssertEqual(nsError.code, 1, "Код ошибки должен быть 1 при имени, состоящем только из пробелов.")
        }
    }
    
    /// Тест для проверки ошибки при нулевой сумме.
    ///
    /// Проверяет, что выбрасывается ошибка, если сумма модификатора равна нулю.
    func testCreateDiscountModifier_ZeroSum_ThrowsError() {
        let discount = Discount()
        let sum: Kkm_Proto_Money
        do {
            sum = try Money().createMoney(bills: 0, coins: 0)
        } catch {
            XCTFail("Ошибка при создании Money: \(error)")
            return
        }
        
        XCTAssertThrowsError(try discount.createDicountModifier(name: "Скидка 5%", sum: sum)) { error in
            let nsError = error as NSError
            XCTAssertEqual(nsError.domain, "validateSumDiscount", "Домен ошибки должен быть validateSumDiscount.")
            XCTAssertEqual(nsError.code, 2, "Код ошибки должен быть 2 при нулевой сумме.")
        }
    }
    
    /// Тест для проверки успешного создания модификатора с суммой только в монетах.
    ///
    /// Проверяет, что модификатор создается корректно, если сумма указана только в монетах.
    func testCreateDiscountModifier_OnlyCoins_Success() throws {
        let discount = Discount()
        let sum = try Money().createMoney(bills: 0, coins: 50)
        let modifier = try discount.createDicountModifier(name: "Скидка на монеты", sum: sum)
        
        XCTAssertEqual(modifier.name, "Скидка на монеты", "Имя модификатора должно совпадать с введенным.")
        XCTAssertEqual(modifier.sum, sum, "Сумма модификатора должна совпадать с введенной.")
    }
    
    /// Тест для проверки успешного создания модификатора с суммой только в банкнотах.
    ///
    /// Проверяет, что модификатор создается корректно, если сумма указана только в банкнотах.
    func testCreateDiscountModifier_OnlyBills_Success() throws {
        let discount = Discount()
        let sum = try Money().createMoney(bills: 1000, coins: 0)
        let modifier = try discount.createDicountModifier(name: "Скидка на банкноты", sum: sum)
        
        XCTAssertEqual(modifier.name, "Скидка на банкноты", "Имя модификатора должно совпадать с введенным.")
        XCTAssertEqual(modifier.sum, sum, "Сумма модификатора должна совпадать с введенной.")
    }
}
