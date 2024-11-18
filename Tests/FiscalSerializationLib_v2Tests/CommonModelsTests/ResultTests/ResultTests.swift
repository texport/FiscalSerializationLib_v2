//
//  ResultTests.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 18.11.2024.
//

import XCTest
@testable import FiscalSerializationLib_v2

/// Тесты для проверки работы структуры `Result`.
///
/// Данные тесты проверяют корректность работы метода `createResult`, который обрабатывает коды ответов от сервера оператора фискальных данных (ОФД).
/// Тесты охватывают успешные случаи обработки известных кодов, а также обработку ошибок для неизвестных кодов.
final class ResultTests: XCTestCase {
    /// Тест успешного создания результата с корректным кодом ответа.
    ///
    /// Проверяет, что при передаче корректного кода `ok` метод `createResult`:
    /// - Возвращает правильный код ответа, соответствующий `ResultTypeEnum.ok.rawValue`.
    /// - Возвращает правильное описание, соответствующее `ResultTypeEnum.ok.description`.
    func testCreateResult_Success() {
        // Подготавливаем тестовые данные
        let result = Kkm_Proto_Result.with {
            $0.resultCode = ResultTypeEnum.ok.rawValue
        }
        
        do {
            // Выполняем обработку результата
            let (code, description) = try Result.createResult(result: result)
            
            // Проверяем корректность кода и описания
            XCTAssertEqual(code, ResultTypeEnum.ok.rawValue, "Неверный код ответа")
            XCTAssertEqual(description, ResultTypeEnum.ok.description, "Неверное описание")
        } catch {
            XCTFail("Не ожидалось исключение: \(error.localizedDescription)")
        }
    }
    
    /// Тест обработки некорректного кода ответа, не соответствующего протоколу.
    ///
    /// Проверяет, что при передаче некорректного кода метод `createResult` выбрасывает ошибку с кодом `1`.
    func testCreateResult_UnknownProtocolCode() {
        // Подготавливаем тестовые данные с некорректным кодом
        let result = Kkm_Proto_Result.with {
            $0.resultCode = 999 // Некорректный код, не соответствующий протоколу
        }
        
        do {
            _ = try Result.createResult(result: result)
            XCTFail("Ожидалось исключение, но оно не было выброшено")
        } catch let error as NSError {
            XCTAssertEqual(error.domain, "createResult")
            XCTAssertEqual(error.code, 1)
            XCTAssertEqual(
                error.localizedDescription,
                "Полученный код ответа от ОФД не соответствует протоколу. Обратитесь в службу поддержки ОФД, предоставив идентификатор кассы, время попытки и код ответа: 999."
            )
        }
    }
    
    /// Тест обработки кода ответа, который допустим по протоколу, но не распознан библиотекой.
    ///
    /// Проверяет, что при передаче кода, допустимого по протоколу, но неизвестного библиотеке, метод `createResult` выбрасывает ошибку с кодом `2`.
    func testCreateResult_UnknownLibraryCode() {
        // Подготавливаем тестовые данные с допустимым по протоколу, но неизвестным кодом
        let result = Kkm_Proto_Result.with {
            $0.resultCode = 16 // Допустимый код по протоколу, но не поддерживаемый библиотекой
        }
        
        do {
            _ = try Result.createResult(result: result)
            XCTFail("Ожидалось исключение, но оно не было выброшено")
        } catch let error as NSError {
            XCTAssertEqual(error.domain, "createResult")
            XCTAssertEqual(error.code, 2)
            XCTAssertEqual(
                error.localizedDescription,
                "Код ответа от ОФД допустим по протоколу, но не распознан библиотекой. Обратитесь к разработчику библиотеки."
            )
        }
    }
}
