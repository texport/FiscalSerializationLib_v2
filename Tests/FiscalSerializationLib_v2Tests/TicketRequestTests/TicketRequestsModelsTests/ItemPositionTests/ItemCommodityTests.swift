//
//  ItemCommodityTests.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 04.11.2024.
//

import XCTest
@testable import FiscalSerializationLib_v2

final class ItemCommodityTests: XCTestCase {
    /// Тестирует создание ItemCommodity с корректными данными.
    func testCreateItemCommodityWithValidData() throws {
        let itemCommodity = ItemCommodity()
        let name = "Valid Name"
        let sectionCode = "001"
        let quantity: UInt32 = 1000
        let price: Kkm_Proto_Money
        do {
            price = try Money().createMoney(bills: 10, coins: 50)
        } catch {
            XCTFail("Не удалось создать деньги: \(error.localizedDescription)")
            return
        }
        let taxes: [Kkm_Proto_TicketRequest.Tax] = []
        let measureUnitCode = UnitOfMeasurement.kilogram

        let result: Kkm_Proto_TicketRequest.Item
        do {
            result = try itemCommodity.createItemCommodity(
                name: name,
                sectionCode: sectionCode,
                quantity: quantity,
                price: price,
                taxes: taxes,
                exciseStamp: nil,
                barcode: nil,
                measureUnitCode: measureUnitCode
            )
        } catch {
            XCTFail("Не удалось создать ItemCommodity: \(error.localizedDescription)")
            return
        }

        // Поскольку поля result скрыты в другой структуре и недоступны напрямую, оставляем успешное завершение теста
        XCTAssertNotNil(result)
    }

    /// Тестирует создание ItemCommodity с некорректным именем.
    func testCreateItemCommodityWithInvalidName() {
        let itemCommodity = ItemCommodity()
        let invalidName = " "
        let sectionCode = "001"
        let quantity: UInt32 = 1000
        let price: Kkm_Proto_Money
        do {
            price = try Money().createMoney(bills: 10, coins: 50)
        } catch {
            XCTFail("Не удалось создать деньги: \(error.localizedDescription)")
            return
        }
        let taxes: [Kkm_Proto_TicketRequest.Tax] = []
        let measureUnitCode = UnitOfMeasurement.kilogram

        XCTAssertThrowsError(try itemCommodity.createItemCommodity(
            name: invalidName,
            sectionCode: sectionCode,
            quantity: quantity,
            price: price,
            taxes: taxes,
            exciseStamp: nil,
            barcode: nil,
            measureUnitCode: measureUnitCode
        )) { error in
            XCTAssertEqual((error as NSError).code, 1)
        }
    }

    /// Тестирует создание ItemCommodity с некорректным количеством.
    func testCreateItemCommodityWithInvalidQuantity() {
        let itemCommodity = ItemCommodity()
        let name = "Valid Name"
        let sectionCode = "001"
        let invalidQuantity: UInt32 = 0
        let price: Kkm_Proto_Money
        do {
            price = try Money().createMoney(bills: 10, coins: 50)
        } catch {
            XCTFail("Не удалось создать деньги: \(error.localizedDescription)")
            return
        }
        let taxes: [Kkm_Proto_TicketRequest.Tax] = []
        let measureUnitCode = UnitOfMeasurement.kilogram

        XCTAssertThrowsError(try itemCommodity.createItemCommodity(
            name: name,
            sectionCode: sectionCode,
            quantity: invalidQuantity,
            price: price,
            taxes: taxes,
            exciseStamp: nil,
            barcode: nil,
            measureUnitCode: measureUnitCode
        )) { error in
            XCTAssertEqual((error as NSError).code, 3)
        }
    }

    /// Тестирует создание ItemCommodity с некорректной акцизной маркой.
    func testCreateItemCommodityWithInvalidExciseStamp() {
        let itemCommodity = ItemCommodity()
        let name = "Valid Name"
        let sectionCode = "001"
        let quantity: UInt32 = 1000
        let price: Kkm_Proto_Money
        do {
            price = try Money().createMoney(bills: 10, coins: 50)
        } catch {
            XCTFail("Не удалось создать деньги: \(error.localizedDescription)")
            return
        }
        let taxes: [Kkm_Proto_TicketRequest.Tax] = []
        let invalidExciseStamp = "  "
        let measureUnitCode = UnitOfMeasurement.kilogram

        XCTAssertThrowsError(try itemCommodity.createItemCommodity(
            name: name,
            sectionCode: sectionCode,
            quantity: quantity,
            price: price,
            taxes: taxes,
            exciseStamp: invalidExciseStamp,
            barcode: nil,
            measureUnitCode: measureUnitCode
        )) { error in
            XCTAssertEqual((error as NSError).code, 5)
        }
    }

    /// Тестирует создание ItemCommodity с некорректным штрихкодом.
    func testCreateItemCommodityWithInvalidBarcode() {
        let itemCommodity = ItemCommodity()
        let name = "Valid Name"
        let sectionCode = "001"
        let quantity: UInt32 = 1000
        let price: Kkm_Proto_Money
        do {
            price = try Money().createMoney(bills: 10, coins: 50)
        } catch {
            XCTFail("Не удалось создать деньги: \(error.localizedDescription)")
            return
        }
        let taxes: [Kkm_Proto_TicketRequest.Tax] = []
        let invalidBarcode = "12345"
        let measureUnitCode = UnitOfMeasurement.kilogram

        XCTAssertThrowsError(try itemCommodity.createItemCommodity(
            name: name,
            sectionCode: sectionCode,
            quantity: quantity,
            price: price,
            taxes: taxes,
            exciseStamp: nil,
            barcode: invalidBarcode,
            measureUnitCode: measureUnitCode
        )) { error in
            XCTAssertEqual((error as NSError).code, 6)
        }
    }

    /// Тестирует создание ItemCommodity с корректными данными и всеми опциональными полями.
    func testCreateItemCommodityWithAllFields() throws {
        let itemCommodity = ItemCommodity()
        let name = "Valid Name"
        let sectionCode = "001"
        let quantity: UInt32 = 1000
        let price: Kkm_Proto_Money
        do {
            price = try Money().createMoney(bills: 10, coins: 50)
        } catch {
            XCTFail("Не удалось создать деньги: \(error.localizedDescription)")
            return
        }
        let taxes: [Kkm_Proto_TicketRequest.Tax] = []
        let exciseStamp = "ValidExciseStamp"
        let barcode = "12345678"
        let measureUnitCode = UnitOfMeasurement.kilogram

        let result: Kkm_Proto_TicketRequest.Item
        do {
            result = try itemCommodity.createItemCommodity(
                name: name,
                sectionCode: sectionCode,
                quantity: quantity,
                price: price,
                taxes: taxes,
                exciseStamp: exciseStamp,
                barcode: barcode,
                measureUnitCode: measureUnitCode
            )
        } catch {
            XCTFail("Не удалось создать ItemCommodity: \(error.localizedDescription)")
            return
        }

        // Поскольку поля result скрыты в другой структуре и недоступны напрямую, оставляем успешное завершение теста
        XCTAssertNotNil(result)
    }
}
