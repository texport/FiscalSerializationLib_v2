//
//  TicketNumberTests.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 18.11.2024.
//

import XCTest
@testable import FiscalSerializationLib_v2

/// Тесты для проверки работы структуры `TicketNumber`.
///
/// Данные тесты проверяют корректность работы метода `createTicketNumber`, включая успешное создание номера чека
/// и обработку ошибок при получении пустого значения.
final class TicketNumberTests: XCTestCase {
    
    // MARK: - Test Cases
    
    /// Тест успешного создания номера чека.
    ///
    /// Проверяет, что метод `createTicketNumber` корректно возвращает непустой номер чека.
    func testCreateTicketNumber_Success() {
        do {
            let ticketNumber = try TicketNumber.createTicketNumber(ticketNumber: "123456")
            XCTAssertEqual(ticketNumber, "123456", "Неверный номер чека")
        } catch {
            XCTFail("Не ожидалось исключение: \(error.localizedDescription)")
        }
    }
    
    /// Тест обработки ошибки при передаче пустого номера чека.
    ///
    /// Проверяет, что метод `createTicketNumber` выбрасывает ошибку с кодом `1` при пустом значении.
    func testCreateTicketNumber_EmptyError() {
        do {
            _ = try TicketNumber.createTicketNumber(ticketNumber: "")
            XCTFail("Ожидалось исключение, но оно не было выброшено")
        } catch let error as NSError {
            XCTAssertEqual(error.domain, "TicketNumber")
            XCTAssertEqual(error.code, 1)
            XCTAssertEqual(
                error.localizedDescription,
                "ОФД отправил пустой фискальный признак. ОФД нарушил протокол. Обратитесь в службу поддержки ОФД. Предоставьте ОФД идентификатор кассы, время попытки отправки транзакции, и сообщите информацию о пустом фискальном признаке."
            )
        }
    }
}
