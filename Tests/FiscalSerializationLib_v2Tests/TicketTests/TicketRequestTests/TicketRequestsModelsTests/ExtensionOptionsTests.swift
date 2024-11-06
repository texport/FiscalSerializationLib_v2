//
//  ExtensionOptionsTests.swift
//  FiscalSerializationLib_v2Tests
//
//  Created by Sergey Ivanov on 01.11.2024.
//

import XCTest
@testable import FiscalSerializationLib_v2

/// Тесты для структуры `ExtensionOptions`
final class ExtensionOptionsTests: XCTestCase {
    
    var extensionOptions: ExtensionOptions!
    
    override func setUp() {
        super.setUp()
        extensionOptions = ExtensionOptions()
    }
    
    override func tearDown() {
        extensionOptions = nil
        super.tearDown()
    }
    
    // MARK: - Тесты для создания ExtensionOptions
    
    /// Тест для проверки создания объекта с корректным номером телефона
    func testCreateExtensionOptions_WithValidPhone() throws {
        let phone = "+71234567890"
        let options = try extensionOptions.createExtensionOptions(phone: phone, email: nil, iinOrBin: nil)
        
        // Добавьте распечатку значения для отладки
        print("customerEmail: \(String(describing: options.customerEmail))")
        
        XCTAssertEqual(options.customerPhone, phone)
    }
    
    /// Тест для проверки создания объекта с корректным email
    func testCreateExtensionOptions_WithValidEmail() throws {
        let email = "test@example.com"
        let options = try extensionOptions.createExtensionOptions(phone: nil, email: email, iinOrBin: nil)
        
        XCTAssertEqual(options.customerEmail, email)
    }
    
    /// Тест для проверки создания объекта с корректным ИИН/БИН
    func testCreateExtensionOptions_WithValidIinOrBin() throws {
        let iinOrBin = "123456789012"
        let options = try extensionOptions.createExtensionOptions(phone: nil, email: nil, iinOrBin: iinOrBin)
        
        XCTAssertEqual(options.customerIinOrBin, iinOrBin)
    }
    
    /// Тест для проверки создания объекта с всеми корректными значениями
    func testCreateExtensionOptions_WithAllValidValues() throws {
        let phone = "+71234567890"
        let email = "test@example.com"
        let iinOrBin = "123456789012"
        
        let options = try extensionOptions.createExtensionOptions(phone: phone, email: email, iinOrBin: iinOrBin)
        
        XCTAssertEqual(options.customerPhone, phone)
        XCTAssertEqual(options.customerEmail, email)
        XCTAssertEqual(options.customerIinOrBin, iinOrBin)
    }
    
    // MARK: - Тесты для выброса ошибок
    
    /// Тест для проверки выброса ошибки при отсутствии всех параметров
    func testCreateExtensionOptions_WithoutAnyValues() {
        XCTAssertThrowsError(try extensionOptions.createExtensionOptions(phone: nil, email: nil, iinOrBin: nil)) { error in
            XCTAssertEqual((error as NSError).domain, "createExtensionOptions")
            XCTAssertEqual((error as NSError).code, 1)
        }
    }
    
    /// Тест для проверки выброса ошибки при неверном формате номера телефона
    func testCreateExtensionOptions_WithInvalidPhone() {
        let phone = "1234567890" // Неверный формат
        XCTAssertThrowsError(try extensionOptions.createExtensionOptions(phone: phone, email: nil, iinOrBin: nil)) { error in
            XCTAssertEqual((error as NSError).domain, "validatePhone")
            XCTAssertEqual((error as NSError).code, 2)
        }
    }
    
    /// Тест для проверки выброса ошибки при неверном формате email
    func testCreateExtensionOptions_WithInvalidEmail() {
        let email = "invalid-email" // Неверный формат
        XCTAssertThrowsError(try extensionOptions.createExtensionOptions(phone: nil, email: email, iinOrBin: nil)) { error in
            XCTAssertEqual((error as NSError).domain, "validateEmail")
            XCTAssertEqual((error as NSError).code, 3)
        }
    }
    
    /// Тест для проверки выброса ошибки при неверном формате ИИН/БИН
    func testCreateExtensionOptions_WithInvalidIinOrBin() {
        let iinOrBin = "12345" // Неверный формат (меньше 12 символов)
        XCTAssertThrowsError(try extensionOptions.createExtensionOptions(phone: nil, email: nil, iinOrBin: iinOrBin)) { error in
            XCTAssertEqual((error as NSError).domain, "validateIinOrBin")
            XCTAssertEqual((error as NSError).code, 4)
        }
    }
    
    /// Тест для проверки выброса ошибки при неверном формате телефона с неправильным кодом
    func testCreateExtensionOptions_WithInvalidPhoneCode() {
        let phone = "+81234567890" // Неверный код страны
        XCTAssertThrowsError(try extensionOptions.createExtensionOptions(phone: phone, email: nil, iinOrBin: nil)) { error in
            XCTAssertEqual((error as NSError).domain, "validatePhone")
            XCTAssertEqual((error as NSError).code, 2)
        }
    }
    
    /// Тест для проверки выброса ошибки при пустом email
    func testCreateExtensionOptions_WithEmptyEmail() {
        let email = "" // Пустой email
        XCTAssertThrowsError(try extensionOptions.createExtensionOptions(phone: nil, email: email, iinOrBin: nil)) { error in
            XCTAssertEqual((error as NSError).domain, "validateEmail")
            XCTAssertEqual((error as NSError).code, 3)
        }
    }
    
    /// Тест для проверки выброса ошибки при пустом ИИН/БИН
    func testCreateExtensionOptions_WithEmptyIinOrBin() {
        let iinOrBin = "" // Пустой ИИН/БИН
        XCTAssertThrowsError(try extensionOptions.createExtensionOptions(phone: nil, email: nil, iinOrBin: iinOrBin)) { error in
            XCTAssertEqual((error as NSError).domain, "validateIinOrBin")
            XCTAssertEqual((error as NSError).code, 4)
        }
    }

    /// Тест для проверки граничных значений телефонного номера
    func testCreateExtensionOptions_BoundaryPhoneNumber() throws {
        let minPhone = "+70000000000"
        let maxPhone = "+79999999999"
        
        let minOptions = try extensionOptions.createExtensionOptions(phone: minPhone, email: nil, iinOrBin: nil)
        let maxOptions = try extensionOptions.createExtensionOptions(phone: maxPhone, email: nil, iinOrBin: nil)
        
        XCTAssertEqual(minOptions.customerPhone, minPhone)
        XCTAssertEqual(maxOptions.customerPhone, maxPhone)
    }

    /// Тест для проверки email с минимальным набором символов
    func testCreateExtensionOptions_MinimalValidEmail() throws {
        let email = "a@b.co"
        let options = try extensionOptions.createExtensionOptions(phone: nil, email: email, iinOrBin: nil)
        
        XCTAssertEqual(options.customerEmail, email)
    }

    /// Тест для проверки ИИН/БИН с 12 цифрами (граничное значение)
    func testCreateExtensionOptions_BoundaryIinOrBin() throws {
        let iinOrBin = "123456789012"
        let options = try extensionOptions.createExtensionOptions(phone: nil, email: nil, iinOrBin: iinOrBin)
        
        XCTAssertEqual(options.customerIinOrBin, iinOrBin)
    }

    /// Тест для проверки наличия пробелов в телефонном номере
    func testCreateExtensionOptions_PhoneWithSpaces() {
        let phone = " +71234567890 " // Номер с пробелами
        XCTAssertThrowsError(try extensionOptions.createExtensionOptions(phone: phone, email: nil, iinOrBin: nil)) { error in
            XCTAssertEqual((error as NSError).domain, "validatePhone")
            XCTAssertEqual((error as NSError).code, 2)
        }
    }

    /// Тест для проверки наличия пробелов в email
    func testCreateExtensionOptions_EmailWithSpaces() {
        let email = " test@example.com " // Email с пробелами
        XCTAssertThrowsError(try extensionOptions.createExtensionOptions(phone: nil, email: email, iinOrBin: nil)) { error in
            XCTAssertEqual((error as NSError).domain, "validateEmail")
            XCTAssertEqual((error as NSError).code, 3)
        }
    }

    /// Тест для проверки наличия пробелов в ИИН/БИН
    func testCreateExtensionOptions_IinOrBinWithSpaces() {
        let iinOrBin = " 123456789012 " // ИИН/БИН с пробелами
        XCTAssertThrowsError(try extensionOptions.createExtensionOptions(phone: nil, email: nil, iinOrBin: iinOrBin)) { error in
            XCTAssertEqual((error as NSError).domain, "validateIinOrBin")
            XCTAssertEqual((error as NSError).code, 4)
        }
    }

}
