//
//  PosRegInfoTests.swift
//  FiscalSerializationLib_v2Tests
//
//  Created by Sergey Ivanov on 19.11.2024.
//

import XCTest
@testable import FiscalSerializationLib_v2

/// Тесты для структуры `PosRegInfo`.
final class PosRegInfoTests: XCTestCase {
    
    /// Тест успешной обработки корректного объекта `Kkm_Proto_PosRegInfo`.
    ///
    /// Проверяет, что объект `PosRegInfoResponse` создается корректно, если `title` и `address` заполнены.
    func testCreatePosRegInfoResponse_Success() {
        // Подготавливаем корректный объект ответа
        var protoResponse = Kkm_Proto_PosRegInfo()
        protoResponse.title = "Торговая точка"
        protoResponse.address = "Адрес торговой точки"
        
        do {
            // Пытаемся создать объект
            let response = try PosRegInfo.createPosRegInfoResponse(posRegInfoResponse: protoResponse)
            
            // Проверяем корректность данных
            XCTAssertEqual(response.title, "Торговая точка")
            XCTAssertEqual(response.address, "Адрес торговой точки")
        } catch {
            XCTFail("Не ожидалась ошибка: \(error.localizedDescription)")
        }
    }
    
    /// Тест ошибки при пустом поле `title`.
    ///
    /// Проверяет, что метод выбрасывает ошибку, если `title` пустое или состоит только из пробелов.
    func testCreatePosRegInfoResponse_EmptyTitle() {
        // Подготавливаем объект с пустым полем `title`
        var protoResponse = Kkm_Proto_PosRegInfo()
        protoResponse.title = "   "
        protoResponse.address = "Адрес торговой точки"
        
        XCTAssertThrowsError(try PosRegInfo.createPosRegInfoResponse(posRegInfoResponse: protoResponse)) { error in
            guard let nsError = error as NSError? else {
                XCTFail("Ошибка должна быть NSError")
                return
            }
            
            XCTAssertEqual(nsError.domain, "createPosRegInfoResponse")
            XCTAssertEqual(nsError.code, 1)
            XCTAssertEqual(nsError.localizedDescription, "ОФД НАРУШИЛ ПРОТОКОЛ: Название торговой точки (title) отсутствует или пустое. Обратитесь в службу поддержки ОФД.")
        }
    }
    
    /// Тест ошибки при пустом поле `address`.
    ///
    /// Проверяет, что метод выбрасывает ошибку, если `address` пустое или состоит только из пробелов.
    func testCreatePosRegInfoResponse_EmptyAddress() {
        // Подготавливаем объект с пустым полем `address`
        var protoResponse = Kkm_Proto_PosRegInfo()
        protoResponse.title = "Торговая точка"
        protoResponse.address = "   "
        
        XCTAssertThrowsError(try PosRegInfo.createPosRegInfoResponse(posRegInfoResponse: protoResponse)) { error in
            guard let nsError = error as NSError? else {
                XCTFail("Ошибка должна быть NSError")
                return
            }
            
            XCTAssertEqual(nsError.domain, "createPosRegInfoResponse")
            XCTAssertEqual(nsError.code, 2)
            XCTAssertEqual(nsError.localizedDescription, "ОФД НАРУШИЛ ПРОТОКОЛ: Адрес торговой точки (address) отсутствует или пустой. Обратитесь в службу поддержки ОФД.")
        }
    }
}
