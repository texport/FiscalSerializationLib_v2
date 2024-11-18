//
//  UrlTicketOfdTests.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 18.11.2024.
//

import XCTest
@testable import FiscalSerializationLib_v2

/// Тесты для проверки работы структуры `UrlTicketOfd`.
///
/// Данные тесты проверяют корректность работы метода `createUrlTicketOfd`, включая успешное создание URL и обработку ошибок при некорректных данных.
final class UrlTicketOfdTests: XCTestCase {
    
    // MARK: - Test Cases
    
    /// Тест успешного создания URL из данных.
    ///
    /// Проверяет, что метод `createUrlTicketOfd` корректно возвращает URL при передаче валидных данных.
    func testCreateUrlTicketOfd_Success() {
        do {
            let urlData = "https://example.com/ticket/123".data(using: .utf8)!
            let urlString = try UrlTicketOfd.createUrlTicketOfd(urlTicketOfd: urlData)
            XCTAssertEqual(urlString, "https://example.com/ticket/123", "Неверный URL")
        } catch {
            XCTFail("Не ожидалось исключение: \(error.localizedDescription)")
        }
    }
    
    /// Тест обработки ошибки при невозможности преобразовать данные в строку.
    ///
    /// Проверяет, что метод `createUrlTicketOfd` выбрасывает ошибку с кодом `1`, если данные не могут быть преобразованы в строку.
    func testCreateUrlTicketOfd_InvalidDataError() {
        // Подготавливаем некорректные данные (например, байты, которые не могут быть интерпретированы как строка)
        let invalidData = Data([0xFF, 0xD8, 0xFF])
        
        do {
            _ = try UrlTicketOfd.createUrlTicketOfd(urlTicketOfd: invalidData)
            XCTFail("Ожидалось исключение, но оно не было выброшено")
        } catch let error as NSError {
            XCTAssertEqual(error.domain, "UrlTicketOfd")
            XCTAssertEqual(error.code, 1)
            XCTAssertEqual(error.localizedDescription, "Невозможно преобразовать данные в строку.")
        }
    }
    
    /// Тест обработки ошибки при передаче некорректного URL.
    ///
    /// Проверяет, что метод `createUrlTicketOfd` выбрасывает ошибку с кодом `2`, если строка не является допустимым URL.
    func testCreateUrlTicketOfd_InvalidUrlError() {
        let invalidUrlData = "not a valid url".data(using: .utf8)!
        
        do {
            _ = try UrlTicketOfd.createUrlTicketOfd(urlTicketOfd: invalidUrlData)
            XCTFail("Ожидалось исключение, но оно не было выброшено")
        } catch let error as NSError {
            XCTAssertEqual(error.domain, "UrlTicketOfd")
            XCTAssertEqual(error.code, 2)
            XCTAssertEqual(error.localizedDescription, "Строка не является допустимым URL.")
        }
    }
}
