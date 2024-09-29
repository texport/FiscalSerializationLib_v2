//
//  OfdConnectorTest.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 24.09.2024.
//

import XCTest
@testable import FiscalSerializationLib_v2

class OfdConnectorTests: XCTestCase {

    func testSendCommandInfoToOfd() {
        // Данные для тестирования
        let serverIP = "37.150.215.187" // Замените на настоящий IP-адрес сервера
        let serverPort: UInt16 = 7777
        
        // Формирование заголовка
        let header = MessageHeader(
            appCode: 0x81A2,
            version: UInt16(202), // версия 2.0.2
            size: 0, // размер будет вычислен позже
            id: UInt32(200775),
            token: UInt32(46785515),
            reqNum: UInt16(1)
        )

        // Сериализация команды CommandInfo
        let commandSerializer = CommandInfoSerializer()
        
        do {
            // Сериализуем команду и получаем Payload
            let payload = try commandSerializer.serializeCommandInfo()

            // Обновляем размер сообщения
            var fullHeader = header
            fullHeader.size = UInt32(payload.count + 18) // 18 байт на заголовок

            // Сериализуем заголовок
            let headerData = fullHeader.toData()

            // Формируем полное сообщение (header + payload)
            var message = Data()
            message.append(headerData)
            message.append(payload)

            print("Полное сообщение (hex): \(message.map { String(format: "%02hhx", $0) }.joined())")

            // Отправляем сообщение на сервер
            let response = try OfdConnector.shared.sendToServer(message: message, serverIP: serverIP, serverPort: serverPort)

            // Проверяем ответ от сервера
            print("Ответ от сервера (hex): \(response.map { String(format: "%02hhx", $0) }.joined())")
            
            // В зависимости от специфики протокола можно добавить больше проверок
            XCTAssert(!response.isEmpty, "Ответ от сервера пустой")

        } catch {
            XCTFail("Ошибка при отправке данных в ОФД: \(error)")
        }
    }
}
