///
///  CommodityTests.swift
///  FiscalSerializationLib_v2
///
///  Created by Sergey Ivanov on 04.11.2024.
///

import XCTest
@testable import FiscalSerializationLib_v2

/// Класс для тестирования функциональности структуры `Commodity`.
final class CommodityTests: XCTestCase {
    /// Тестирует создание товара с корректными данными.
    func testCreateCommodityWithValidData() throws {
        let commodity = Commodity()
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
        let measureUnitCode = UnitOfMeasurement.unit

        let result = try commodity.createCommodity(
            name: name,
            sectionCode: sectionCode,
            quantity: quantity,
            price: price,
            taxes: taxes,
            exciseStamp: nil,
            barcode: nil,
            measureUnitCode: measureUnitCode
        )

        XCTAssertEqual(result.name, name)
        XCTAssertEqual(result.sectionCode, sectionCode)
        XCTAssertEqual(result.quantity, quantity)
        XCTAssertEqual(result.price, price)
        XCTAssertEqual(result.measureUnitCode, measureUnitCode.rawValue)
    }

    /// Тестирует создание товара с некорректным именем.
    func testCreateCommodityWithInvalidName() {
        let commodity = Commodity()
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
        let measureUnitCode = UnitOfMeasurement.unit

        XCTAssertThrowsError(try commodity.createCommodity(
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

    /// Тестирует создание товара с некорректным кодом секции.
    func testCreateCommodityWithInvalidSectionCode() {
        let commodity = Commodity()
        let name = "Valid Name"
        let invalidSectionCode = "  "
        let quantity: UInt32 = 1000
        let price: Kkm_Proto_Money
        do {
            price = try Money().createMoney(bills: 10, coins: 50)
        } catch {
            XCTFail("Не удалось создать деньги: \(error.localizedDescription)")
            return
        }
        let taxes: [Kkm_Proto_TicketRequest.Tax] = []
        let measureUnitCode = UnitOfMeasurement.unit

        XCTAssertThrowsError(try commodity.createCommodity(
            name: name,
            sectionCode: invalidSectionCode,
            quantity: quantity,
            price: price,
            taxes: taxes,
            exciseStamp: nil,
            barcode: nil,
            measureUnitCode: measureUnitCode
        )) { error in
            XCTAssertEqual((error as NSError).code, 2)
        }
    }

    /// Тестирует создание товара с некорректным количеством.
    func testCreateCommodityWithInvalidQuantity() {
        let commodity = Commodity()
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
        let measureUnitCode = UnitOfMeasurement.unit

        XCTAssertThrowsError(try commodity.createCommodity(
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

    /// Тестирует создание товара с некорректной акцизной маркой.
    func testCreateCommodityWithInvalidExciseStamp() {
        let commodity = Commodity()
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
        let measureUnitCode = UnitOfMeasurement.unit

        XCTAssertThrowsError(try commodity.createCommodity(
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

    /// Тестирует создание товара с некорректным штрихкодом.
    func testCreateCommodityWithInvalidBarcode() {
        let commodity = Commodity()
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
        let measureUnitCode = UnitOfMeasurement.unit

        XCTAssertThrowsError(try commodity.createCommodity(
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

    /// Тестирует попытку создать товар с недопустимым значением единицы измерения.
    func testCreateCommodityWithInvalidMeasureUnitCode() {
        let commodity = Commodity()
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

        // Попробуем создать значение UnitOfMeasurement с произвольным значением, которого нет в списке
        let invalidMeasureUnitCodeRawValue = "9999"
        if let invalidMeasureUnitCode = UnitOfMeasurement(rawValue: invalidMeasureUnitCodeRawValue) {
            // Если значение удалось создать, тест должен выбросить ошибку при создании товара
            XCTAssertThrowsError(try commodity.createCommodity(
                name: name,
                sectionCode: sectionCode,
                quantity: quantity,
                price: price,
                taxes: taxes,
                exciseStamp: nil,
                barcode: nil,
                measureUnitCode: invalidMeasureUnitCode
            )) { error in
                XCTAssertEqual((error as NSError).code, 7)
            }
        } else {
            // Если значение не удалось создать, значит `UnitOfMeasurement` не содержит такое rawValue, и это ожидаемое поведение
            XCTAssert(true, "Не удалось создать значение UnitOfMeasurement с недопустимым кодом — это ожидаемое поведение.")
        }
    }
}
