//
//  MessageHeaderTests.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 18.11.2024.
//

import XCTest
@testable import FiscalSerializationLib_v2

/// Тесты для проверки работы структуры `MessageHeader`.
///
/// Эти тесты проверяют корректность работы методов `toData` и `fromData` для формирования и извлечения заголовков сообщений.
final class MessageHeaderTests: XCTestCase {
    /// Тест успешного создания заголовка сообщения и его сериализации в `Data`.
    ///
    /// Проверяет, что заголовок корректно создается и сериализуется.
    func testMessageHeader_toData_Success() {
        // Подготавливаем тестовые данные
        let id: UInt32 = 123456789
        let token: UInt32 = 987654321
        let reqNum: UInt16 = 42
        let payload = "Test payload".data(using: .utf8)!
        
        // Выполняем сериализацию заголовка в `Data`
        let headerData = MessageHeader.toData(id: id, token: token, reqNum: reqNum, payload: payload)
        
        // Проверяем размер данных
        XCTAssertEqual(headerData.count, 18, "Неверный размер заголовка")
        
        // Проверяем правильность содержимого
        XCTAssertEqual(headerData.subdata(in: 0..<2).withUnsafeBytes { $0.load(as: UInt16.self).littleEndian }, 0x81A2)
        XCTAssertEqual(headerData.subdata(in: 2..<4).withUnsafeBytes { $0.load(as: UInt16.self).littleEndian }, 202)
        XCTAssertEqual(headerData.subdata(in: 4..<8).withUnsafeBytes { $0.load(as: UInt32.self).littleEndian }, UInt32(payload.count + 18))
        XCTAssertEqual(headerData.subdata(in: 8..<12).withUnsafeBytes { $0.load(as: UInt32.self).littleEndian }, id)
        XCTAssertEqual(headerData.subdata(in: 12..<16).withUnsafeBytes { $0.load(as: UInt32.self).littleEndian }, token)
        XCTAssertEqual(headerData.subdata(in: 16..<18).withUnsafeBytes { $0.load(as: UInt16.self).littleEndian }, reqNum)
    }
    
    /// Тест успешной десериализации данных в структуру `MessageHeader`.
    ///
    /// Проверяет, что метод `fromData` корректно извлекает значения из `Data`.
    func testMessageHeader_fromData_Success() {
        // Подготавливаем тестовые данные для десериализации
        let appCode: UInt16 = 0x81A2
        let version: UInt16 = 202
        let size: UInt32 = 50
        let id: UInt32 = 123456789
        let token: UInt32 = 987654321
        let reqNum: UInt16 = 42
        
        var headerData = Data()
        headerData.append(contentsOf: withUnsafeBytes(of: appCode.littleEndian, Array.init))
        headerData.append(contentsOf: withUnsafeBytes(of: version.littleEndian, Array.init))
        headerData.append(contentsOf: withUnsafeBytes(of: size.littleEndian, Array.init))
        headerData.append(contentsOf: withUnsafeBytes(of: id.littleEndian, Array.init))
        headerData.append(contentsOf: withUnsafeBytes(of: token.littleEndian, Array.init))
        headerData.append(contentsOf: withUnsafeBytes(of: reqNum.littleEndian, Array.init))
        
        do {
            // Выполняем десериализацию данных
            let messageHeader = try MessageHeader.fromData(headerData)
            
            // Проверяем правильность полей
            XCTAssertEqual(messageHeader.appCode, appCode, "Неверный appCode")
            XCTAssertEqual(messageHeader.version, version, "Неверная версия")
            XCTAssertEqual(messageHeader.size, size, "Неверный размер")
            XCTAssertEqual(messageHeader.id, id, "Неверный id")
            XCTAssertEqual(messageHeader.token, token, "Неверный токен")
            XCTAssertEqual(messageHeader.reqNum, reqNum, "Неверный reqNum")
        } catch {
            XCTFail("Не ожидалось исключение: \(error.localizedDescription)")
        }
    }
    
    /// Тест обработки ошибки при десериализации из данных недостаточного размера.
    ///
    /// Проверяет, что метод `fromData` выбрасывает ошибку при передаче данных размером менее 18 байт.
    func testMessageHeader_fromData_Error() {
        // Подготавливаем некорректные данные (меньше 18 байт)
        let invalidData = Data(repeating: 0, count: 10)
        
        do {
            _ = try MessageHeader.fromData(invalidData)
            XCTFail("Ожидалось исключение, но оно не было выброшено")
        } catch let error as NSError {
            XCTAssertEqual(error.domain, "MessageHeaderError")
            XCTAssertEqual(error.code, 1)
            XCTAssertEqual(error.localizedDescription, "Неверный размер данных для заголовка")
        }
    }
}
