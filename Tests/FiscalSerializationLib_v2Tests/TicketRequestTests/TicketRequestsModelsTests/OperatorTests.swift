//
//  OperatorTests.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 05.11.2024.
//

import XCTest
@testable import FiscalSerializationLib_v2

final class OperatorTests: XCTestCase {
    
    var operatorInstance: Operator!
    
    // MARK: - Setup/Teardown Methods
    
    override func setUp() {
        super.setUp()
        operatorInstance = Operator()
    }
    
    override func tearDown() {
        operatorInstance = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    /// Тест для успешного создания оператора с корректными данными.
    func testCreateOperator_WithValidData_ShouldReturnOperator() throws {
        let code: UInt32 = 1
        let name = "Имя Оператор"
        
        let createdOperator = try operatorInstance.createOperator(code: code, name: name)
        
        XCTAssertEqual(createdOperator.code, code, "Код оператора должен совпадать с переданным значением.")
        XCTAssertEqual(createdOperator.name, name, "Имя оператора должно совпадать с переданным значением.")
    }
    
    /// Тест для проверки выброса ошибки при коде оператора равном нулю.
    func testCreateOperator_WithZeroCode_ShouldThrowError() {
        let code: UInt32 = 0
        let name = "Имя Оператор"
        
        XCTAssertThrowsError(try operatorInstance.createOperator(code: code, name: name)) { error in
            XCTAssertEqual((error as NSError).domain, "InvalidOperator", "Должен выбрасываться домен ошибки 'InvalidOperator'.")
            XCTAssertEqual((error as NSError).code, 1, "Должен выбрасываться код ошибки 1.")
        }
    }
    
    /// Тест для проверки выброса ошибки при пустом имени.
    func testCreateOperator_WithEmptyName_ShouldThrowError() {
        let code: UInt32 = 1
        let name = ""
        
        XCTAssertThrowsError(try operatorInstance.createOperator(code: code, name: name)) { error in
            XCTAssertEqual((error as NSError).domain, "InvalidOperator", "Должен выбрасываться домен ошибки 'InvalidOperator'.")
            XCTAssertEqual((error as NSError).code, 2, "Должен выбрасываться код ошибки 2.")
        }
    }
    
    /// Тест для проверки выброса ошибки при имени, содержащем только пробелы.
    func testCreateOperator_WithWhitespaceName_ShouldThrowError() {
        let code: UInt32 = 1
        let name = "   "
        
        XCTAssertThrowsError(try operatorInstance.createOperator(code: code, name: name)) { error in
            XCTAssertEqual((error as NSError).domain, "InvalidOperator", "Должен выбрасываться домен ошибки 'InvalidOperator'.")
            XCTAssertEqual((error as NSError).code, 2, "Должен выбрасываться код ошибки 2.")
        }
    }
    
    /// Тест для проверки выброса ошибки при имени, содержащем недопустимые символы.
    func testCreateOperator_WithInvalidCharactersInName_ShouldThrowError() {
        let code: UInt32 = 1
        let name = "Имя123!"
        
        XCTAssertThrowsError(try operatorInstance.createOperator(code: code, name: name)) { error in
            XCTAssertEqual((error as NSError).domain, "InvalidOperator", "Должен выбрасываться домен ошибки 'InvalidOperator'.")
            XCTAssertEqual((error as NSError).code, 3, "Должен выбрасываться код ошибки 3.")
        }
    }
    
    /// Тест для проверки выброса ошибки при имени, длина которого превышает максимальную длину.
    func testCreateOperator_WithLongName_ShouldThrowError() {
        let code: UInt32 = 1
        let name = String(repeating: "A", count: 51)
        
        XCTAssertThrowsError(try operatorInstance.createOperator(code: code, name: name)) { error in
            XCTAssertEqual((error as NSError).domain, "InvalidOperator", "Должен выбрасываться домен ошибки 'InvalidOperator'.")
            XCTAssertEqual((error as NSError).code, 4, "Должен выбрасываться код ошибки 4.")
        }
    }
    
    /// Тест для успешного создания оператора с именем, содержащим несколько слов с одним пробелом между ними.
    func testCreateOperator_WithNameContainingMultipleWords_ShouldReturnOperator() throws {
        let code: UInt32 = 1
        let name = "Имя Оператор Сотрудник"
        
        let createdOperator = try operatorInstance.createOperator(code: code, name: name)
        
        XCTAssertEqual(createdOperator.name, name, "Имя оператора должно быть корректно обработано и совпадать с переданным значением.")
    }
}
