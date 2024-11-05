//
//  ItemDiscountTests.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 05.11.2024.
//

import XCTest
@testable import FiscalSerializationLib_v2

/// Класс тестов для структуры `ItemDiscount`.
final class ItemDiscountTests: XCTestCase {
    
    var itemDiscount: ItemDiscount!
    
    /// Создает экземпляр `ItemDiscount` перед каждым тестом.
    override func setUp() {
        super.setUp()
        itemDiscount = ItemDiscount()
    }
    
    /// Очищает экземпляр `ItemDiscount` после каждого теста.
    override func tearDown() {
        itemDiscount = nil
        super.tearDown()
    }
    
    /// Проверяет, что метод `createItemDiscount` возвращает корректный объект `Item` при правильных данных.
    ///
    /// - Throws: Ошибка, если метод не возвращает корректный объект.
    func testCreateItemDiscount_WithValidInput_ShouldReturnItem() throws {
        let name = "Discount Name"
        let sum = try Money().createMoney(bills: 10, coins: 50)
        
        let item = try itemDiscount.createItemDiscount(name: name, sum: sum)
        
        XCTAssertEqual(item.type, Kkm_Proto_TicketRequest.Item.ItemTypeEnum.itemTypeDiscount, "Тип элемента должен быть itemTypeDiscount")
        XCTAssertEqual(item.discount.name, name, "Название скидки должно совпадать с переданным значением")
        XCTAssertEqual(item.discount.sum, sum, "Сумма скидки должна совпадать с переданным значением")
    }
    
    /// Проверяет, что метод `createItemDiscount` выбрасывает ошибку при передаче пустого имени.
    func testCreateItemDiscount_WithEmptyName_ShouldThrowError() {
        let name = ""
        let sum = try! Money().createMoney(bills: 10, coins: 50)
        
        XCTAssertThrowsError(try itemDiscount.createItemDiscount(name: name, sum: sum), "Ожидается выброс ошибки при передаче пустого имени")
    }
    
    /// Проверяет, что метод `createItemDiscount` выбрасывает ошибку при передаче имени, состоящего только из пробелов.
    func testCreateItemDiscount_WithWhitespaceName_ShouldThrowError() {
        let name = "   "
        let sum = try! Money().createMoney(bills: 10, coins: 50)
        
        XCTAssertThrowsError(try itemDiscount.createItemDiscount(name: name, sum: sum), "Ожидается выброс ошибки при передаче имени, состоящего только из пробелов")
    }
    
    /// Проверяет, что метод `createItemDiscount` выбрасывает ошибку при передаче суммы равной нулю.
    func testCreateItemDiscount_WithZeroSum_ShouldThrowError() {
        let name = "Valid Name"
        let sum = try! Money().createMoney(bills: 0, coins: 0)
        
        XCTAssertThrowsError(try itemDiscount.createItemDiscount(name: name, sum: sum), "Ожидается выброс ошибки при передаче суммы, равной нулю")
    }
    
    /// Проверяет, что метод `createItemDiscount` корректно работает при минимально возможной положительной сумме.
    func testCreateItemDiscount_WithMinimumPositiveSum_ShouldReturnItem() throws {
        let name = "Valid Name"
        let sum = try Money().createMoney(bills: 0, coins: 1)
        
        let item = try itemDiscount.createItemDiscount(name: name, sum: sum)
        
        XCTAssertEqual(item.type, Kkm_Proto_TicketRequest.Item.ItemTypeEnum.itemTypeDiscount, "Тип элемента должен быть itemTypeDiscount")
        XCTAssertEqual(item.discount.name, name, "Название скидки должно совпадать с переданным значением")
        XCTAssertEqual(item.discount.sum, sum, "Сумма скидки должна совпадать с переданным значением")
    }
    
    /// Проверяет, что метод `createItemDiscount` корректно работает при максимальной сумме.
    func testCreateItemDiscount_WithLargeSum_ShouldReturnItem() throws {
        let name = "Large Discount"
        let sum = try Money().createMoney(bills: UInt64(Int.max), coins: 99)
        
        let item = try itemDiscount.createItemDiscount(name: name, sum: sum)
        
        XCTAssertEqual(item.type, Kkm_Proto_TicketRequest.Item.ItemTypeEnum.itemTypeDiscount, "Тип элемента должен быть itemTypeDiscount")
        XCTAssertEqual(item.discount.name, name, "Название скидки должно совпадать с переданным значением")
        XCTAssertEqual(item.discount.sum, sum, "Сумма скидки должна совпадать с переданным значением")
    }
}
