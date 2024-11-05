//
//  OfdConnectorTest.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 24.09.2024.
//

import XCTest
@testable import FiscalSerializationLib_v2

class OfdConnectorTests: XCTestCase {

    // Данные для тестирования
    let serverIP = "37.150.215.187" // Замените на настоящий IP-адрес сервера
    let serverPort: UInt16 = 7777
    
    // Формирование заголовка
    let header = MessageHeader(
        appCode: 0x81A2,
        version: UInt16(202), // версия 2.0.2
        size: 0, // размер будет вычислен позже
        id: UInt32(200956),
        token: UInt32(2688764498),
        reqNum: UInt16(20)
    )
    
    func testSendCommandInfoToOfd() {
        // Сериализация команды CommandInfo
        let commandInfo = CommandInfo()
        
        do {
            // Сериализуем команду и получаем Payload
            let payload = try commandInfo.serializeCommandInfo()

            // Обновляем размер сообщения
            var fullHeader = header
            fullHeader.size = UInt32(payload.count + 18) // 18 байт на заголовок

            // Сериализуем заголовок
            let headerData = fullHeader.toData()

            try print(MessageHeader.fromData(headerData))
            
            // Формируем полное сообщение (header + payload)
            var message = Data()
            message.append(headerData)
            message.append(payload)

            print("Полное сообщение (hex) перед отправкой: \(message.map { String(format: "%02hhx", $0) }.joined())")

            // Отправляем сообщение на сервер
            let response = try OfdConnector.shared.sendToServer(message: message, serverIP: serverIP, serverPort: serverPort)

            // Проверяем ответ от сервера
            let messageResponse = try MessageHeader.fromData(response)
            let deComandInfo = try commandInfo.deserializeCommandInfoResponse(data: response)
            
            print("Полное сообщение (hex) от сервера: \(response.map { String(format: "%02hhx", $0) }.joined())")
            print("Заголовок от сервера:\n \(messageResponse)")
            print("Payload от сервера:\n \(deComandInfo)")
            // В зависимости от специфики протокола можно добавить больше проверок
            XCTAssert(!response.isEmpty, "Ответ от сервера пустой")

        } catch {
            XCTFail("Ошибка при отправке данных в ОФД: \(error)")
        }
    }
    
    func testSendCommandTicketRequest() {
        var ticket: Ticket?
        var ticketItem1: TicketItem?
        var ticketCpcr: CommandTicketRequest?
        
        do {
            ticket = try Ticket(isTicketOnline: true, offlineTicketNumber: nil,
                                offlinePeriodBeginYear: nil, offlinePeriodBeginMonth: nil, offlinePeriodBeginDay: nil, offlinePeriodBeginHour: nil, offlinePeriodBeginMinute: nil, offlinePeriodBeginSecond: nil,
                                offlinePeriodEndYear: nil, offlinePeriodEndMonth: nil, offlinePeriodEndDay: nil, offlinePeriodEndHour: nil, offlinePeriodEndMinute: nil, offlinePeriodEndSecond: nil,
                                kgdId: "381928371231", kkmOfdId: "200956", kkmSerialNumber: "141412323", title: "ИП МИЧКА ПАВЕЛ АНДРЕЕВИЧ", address: "г. Астана, ул. Ленина 33", iinOrBinOrg: "960624350642", oked: "7281",
                                frShiftNumber: 1,
                                operation: 2,
                                year: 2024, month: 10, day: 31, hour: 23, minute: 0, second: 0,
                                codeOperator: 1, nameOperator: "Сергей Иванов",
                                isCash: true, billsCashSum: 1000, coinsCashSum: 0, billsCashTaken: 1000, coinsCashTaken: 0,
                                isCard: true, billsCardSum: 500, coinsCardSum: 0,
                                isMobile: true, billsMobileSum: 404, coinsMobileSum: 0,
                                isTicketAllTax: true, tax: 12000, billsTax: 204, coinsTax: 0,
                                isTicketAllDiscount: false, discountName: nil, billsDiscount: nil, coinsDiscount: nil,
                                billsTotal: 1904, coinsTotal: 0,
                                isCustomer: true, iinOrBin: "123456789123", phone: "+77777777777", email: "mail@mail.kz")
        } catch {
            XCTFail("Ошибка при создании Ticket: \(error)")
        }
        
        do {
            ticketItem1 = try TicketItem(nameTicketItem: "Самагон", sectionCode: "1", quantity: 1000, measureUnitCode: .piece,
                                         billsPrice: 1904, coinsPrice: 0,
                                         isTicketItemTax: false, tax: nil, billsTax: nil, coinsTax: nil,
                                         isTicketItemDiscount: false, discountName: nil, billsDiscount: nil, coinsDiscount: nil,
                                         dataMatrix: nil, barcode: "12345678")
        } catch {
            XCTFail("Ошибка при создании ticketItem1: \(error)")
        }
        
        var ticketItems: [TicketItem] = []
        
        if let item = ticketItem1 {
            ticketItems.append(item)
        }
        
        do {
            if let ticket = ticket {
                ticketCpcr = try CommandTicketRequest(ticket: ticket, ticketItems: ticketItems)
            } else {
                XCTFail("Ticket не был создан должным образом.")
            }
        } catch {
            XCTFail("Ошибка при создании CommandTicketRequest: \(error)")
        }
        
        do {
            if let ticketCpcr = ticketCpcr {
                let payload = try ticketCpcr.serializeCommandTicketRequest()
                var fullHeader = header
                fullHeader.size = UInt32(payload.count + 18)
                
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
                let messageResponse = try MessageHeader.fromData(response)
                let deCommandTicketResponse = try ticketCpcr.deserializeCommandTicketResponse(data: response)
                
                print("Заголовок от сервера:\n \(messageResponse)")
                print("Payload от сервера:\n \(deCommandTicketResponse)")
                // В зависимости от специфики протокола можно добавить больше проверок
                XCTAssert(!response.isEmpty, "Ответ от сервера пустой")
            } else {
                XCTFail("TicketCpcr не удалось извлечь.")
            }
        } catch {
            XCTFail("Ошибка при отправке данных в ОФД: \(error)")
        }
    }
}
