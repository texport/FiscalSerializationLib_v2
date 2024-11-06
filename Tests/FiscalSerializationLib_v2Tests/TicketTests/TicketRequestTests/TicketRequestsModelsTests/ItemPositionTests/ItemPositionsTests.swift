//
//  ItemPositionsTests.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 06.11.2024.
//

import XCTest
@testable import FiscalSerializationLib_v2

final class ItemPositionsTests: XCTestCase {
    private var itemPositions: ItemPositions!
    
    override func setUp() {
        super.setUp()
        itemPositions = ItemPositions()
    }
    
    override func tearDown() {
        itemPositions = nil
        super.tearDown()
    }
    
    /// Проверяет, что при передаче пустого массива `ticketItems` метод `createItemPositions` выбрасывает ошибку с кодом 1 и соответствующим описанием.
    func testCreateItemPositionsWithEmptyTicketItems() {
        XCTAssertThrowsError(
            try itemPositions.createItemPositions(ticketOperation: 0, isTaxAllTicket: false, isDiscountAllTicket: false, ticketItems: [])
        ) { error in
            XCTAssertEqual((error as NSError).code, 1)
            XCTAssertEqual(error.localizedDescription, "Список товаров и услуг (ticketItems) не может быть пустым.")
        }
    }
    
    /// Проверяет корректное создание позиций при валидном массиве `ticketItems`.
    func testCreateItemPositionsWithValidTicketItems() {
        do {
            let ticketItems = [
                try TicketItem(
                    nameTicketItem: "Test Item",
                    sectionCode: "A001",
                    quantity: 1000,
                    measureUnitCode: .piece,
                    billsPrice: 100,
                    coinsPrice: 0,
                    isTicketItemTax: false,
                    tax: nil,
                    billsTax: nil,
                    coinsTax: nil,
                    isTicketItemDiscount: false,
                    discountName: nil,
                    billsDiscount: nil,
                    coinsDiscount: nil,
                    dataMatrix: nil,
                    barcode: nil
                )
            ]
            
            let items = try itemPositions.createItemPositions(ticketOperation: 0, isTaxAllTicket: false, isDiscountAllTicket: false, ticketItems: ticketItems)
            
            XCTAssertEqual(items.count, 1)
            // Проверяем общее количество элементов
            XCTAssertNotNil(items.first)
        } catch {
            XCTFail("Неожиданная ошибка: \(error)")
        }
    }
    
    /// Проверяет, что при указании налога на весь чек и на позицию одновременно метод выбрасывает ошибку с кодом 2.
    func testCreateItemCommodityWithTaxOnAllTicket() {
        do {
            let ticketItems = [
                try TicketItem(
                    nameTicketItem: "Test Item",
                    sectionCode: "A001",
                    quantity: 1000,
                    measureUnitCode: .piece,
                    billsPrice: 100,
                    coinsPrice: 0,
                    isTicketItemTax: true,
                    tax: 12000,
                    billsTax: 12,
                    coinsTax: 0,
                    isTicketItemDiscount: false,
                    discountName: nil,
                    billsDiscount: nil,
                    coinsDiscount: nil,
                    dataMatrix: nil,
                    barcode: nil
                )
            ]
            
            XCTAssertThrowsError(
                try itemPositions.createItemPositions(ticketOperation: 0, isTaxAllTicket: true, isDiscountAllTicket: false, ticketItems: ticketItems)
            ) { error in
                XCTAssertEqual((error as NSError).code, 2)
            }
        } catch {
            XCTFail("Неожиданная ошибка: \(error)")
        }
    }
    
    /// Проверяет, что при отсутствии значений налога у позиции с флагом `isTicketItemTax` метод `TicketItem` выбрасывает ошибку инициализации.
    func testTicketItemInitializationWithoutTaxValues() {
        XCTAssertThrowsError(
            try TicketItem(
                nameTicketItem: "Test Item",
                sectionCode: "A001",
                quantity: 1000,
                measureUnitCode: .piece,
                billsPrice: 100,
                coinsPrice: 0,
                isTicketItemTax: true,
                tax: nil,
                billsTax: nil,
                coinsTax: nil,
                isTicketItemDiscount: false,
                discountName: nil,
                billsDiscount: nil,
                coinsDiscount: nil,
                dataMatrix: nil,
                barcode: nil
            )
        ) { error in
            XCTAssertEqual((error as NSError).code, 1)
            XCTAssertEqual(error.localizedDescription, "Если налог на позицию (isTicketItemTax), обязательно нужно заполнять tax, billsTax и coinsTax")
        }
    }

    /// Проверяет, что при передаче скидки на операцию возврата метод выбрасывает ошибку с кодом 4.
    func testCreateItemCommodityWithDiscountOnReturnOperation() {
        do {
            let ticketItems = [
                try TicketItem(
                    nameTicketItem: "Test Item",
                    sectionCode: "A001",
                    quantity: 1000,
                    measureUnitCode: .piece,
                    billsPrice: 100,
                    coinsPrice: 0,
                    isTicketItemTax: false,
                    tax: nil,
                    billsTax: nil,
                    coinsTax: nil,
                    isTicketItemDiscount: true,
                    discountName: "Discount",
                    billsDiscount: 5,
                    coinsDiscount: 0,
                    dataMatrix: nil,
                    barcode: nil
                )
            ]
            
            XCTAssertThrowsError(
                try itemPositions.createItemPositions(ticketOperation: 1, isTaxAllTicket: false, isDiscountAllTicket: false, ticketItems: ticketItems)
            ) { error in
                XCTAssertEqual((error as NSError).code, 4)
            }
        } catch {
            XCTFail("Неожиданная ошибка: \(error)")
        }
    }
    
    /// Проверяет, что при отсутствии имени скидки у позиции с флагом `isTicketItemDiscount` метод `TicketItem` выбрасывает ошибку инициализации с кодом 2.
    func testTicketItemInitializationWithoutDiscountName() {
        XCTAssertThrowsError(
            try TicketItem(
                nameTicketItem: "Test Item",
                sectionCode: "A001",
                quantity: 1000,
                measureUnitCode: .piece,
                billsPrice: 100,
                coinsPrice: 0,
                isTicketItemTax: false,
                tax: nil,
                billsTax: nil,
                coinsTax: nil,
                isTicketItemDiscount: true,
                discountName: nil,
                billsDiscount: 5,
                coinsDiscount: 0,
                dataMatrix: nil,
                barcode: nil
            )
        ) { error in
            XCTAssertEqual((error as NSError).code, 2)
            XCTAssertEqual(error.localizedDescription, "Если скидка на позицию (isTicketItemDiscount), обязательно нужно заполнять discountName, billsDiscount и coinsDiscount")
        }
    }

    /// Проверяет корректное создание позиции со скидкой, если указаны все необходимые параметры.
    func testCreateItemDiscountWithValidData() {
        do {
            let ticketItems = [
                try TicketItem(
                    nameTicketItem: "Test Item",
                    sectionCode: "A001",
                    quantity: 1000,
                    measureUnitCode: .piece,
                    billsPrice: 100,
                    coinsPrice: 0,
                    isTicketItemTax: false,
                    tax: nil,
                    billsTax: nil,
                    coinsTax: nil,
                    isTicketItemDiscount: true,
                    discountName: "Discount",
                    billsDiscount: 5,
                    coinsDiscount: 0,
                    dataMatrix: nil,
                    barcode: nil
                )
            ]
            
            let items = try itemPositions.createItemPositions(ticketOperation: 0, isTaxAllTicket: false, isDiscountAllTicket: false, ticketItems: ticketItems)
            
            XCTAssertEqual(items.count, 2) // Один элемент и один модификатор (скидка)
        } catch {
            XCTFail("Неожиданная ошибка: \(error)")
        }
    }
}
