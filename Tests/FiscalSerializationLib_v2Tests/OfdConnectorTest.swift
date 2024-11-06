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
        token: UInt32(3103531874),
        reqNum: UInt16(31)
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
            print("Полное сообщение (hex) от сервера: \(response.map { String(format: "%02hhx", $0) }.joined())")

            // Проверяем ответ от сервера
            let messageResponse = try MessageHeader.fromData(response)
            print("funcCommandInfo Header: \(messageResponse)")
            let deComandInfo = try commandInfo.deserializeCommandInfoResponse(data: response)
            print("funcCommandInfo Payload: \(deComandInfo)")
            
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
        var ticketItem2: TicketItem?
        var ticketItem3: TicketItem?
        var ticketCpcr: Data?
        
        do {
            ticket = try Ticket(isTicketOnline: true, offlineTicketNumber: nil,
                                offlinePeriodBeginYear: nil, offlinePeriodBeginMonth: nil, offlinePeriodBeginDay: nil, offlinePeriodBeginHour: nil, offlinePeriodBeginMinute: nil, offlinePeriodBeginSecond: nil,
                                offlinePeriodEndYear: nil, offlinePeriodEndMonth: nil, offlinePeriodEndDay: nil, offlinePeriodEndHour: nil, offlinePeriodEndMinute: nil, offlinePeriodEndSecond: nil,
                                kgdId: "381928371231", kkmOfdId: "200956", kkmSerialNumber: "141412323", title: "ИП МИЧКА ПАВЕЛ АНДРЕЕВИЧ", address: "г. Астана, ул. Ленина 33", iinOrBinOrg: "960624350642", oked: "7281",
                                frShiftNumber: 1,
                                operation: 2,
                                year: 2024, month: 10, day: 31, hour: 23, minute: 0, second: 0,
                                codeOperator: 1, nameOperator: "Сергей Иванов",
                                isCash: true, billsCashSum: 2700, coinsCashSum: 0, billsCashTaken: 2700, coinsCashTaken: 0,
                                isCard: false, billsCardSum: nil, coinsCardSum: nil,
                                isMobile: false, billsMobileSum: nil, coinsMobileSum: nil,
                                isTicketAllTax: false, tax: nil, billsTax: nil, coinsTax: nil,
                                isTicketAllDiscount: false, discountName: nil, billsDiscount: nil, coinsDiscount: nil,
                                billsTotal: 2700, coinsTotal: 0,
                                isCustomer: true, iinOrBin: "123456789123", phone: "+77777777777", email: "mail@mail.kz")
        } catch {
            XCTFail("Ошибка при создании Ticket: \(error)")
        }
        
        do {
            ticketItem1 = try TicketItem(nameTicketItem: "Игрушка SuperMan", sectionCode: "1", quantity: 1000, measureUnitCode: .piece,
                                         billsPrice: 1000, coinsPrice: 0,
                                         isTicketItemTax: true, tax: 12000, billsTax: 96, coinsTax: 43,
                                         isTicketItemDiscount: true, discountName: "Акция -10%", billsDiscount: 100, coinsDiscount: 0,
                                         dataMatrix: nil, barcode: "12345678")
            ticketItem2 = try TicketItem(nameTicketItem: "Игрушка SuperMan", sectionCode: "1", quantity: 1000, measureUnitCode: .piece,
                                         billsPrice: 1000, coinsPrice: 0,
                                         isTicketItemTax: true, tax: 12000, billsTax: 96, coinsTax: 43,
                                         isTicketItemDiscount: true, discountName: "Акция -10%", billsDiscount: 100, coinsDiscount: 0,
                                         dataMatrix: nil, barcode: "12345678")
            ticketItem3 = try TicketItem(nameTicketItem: "Игрушка SuperMan", sectionCode: "1", quantity: 1000, measureUnitCode: .piece,
                                         billsPrice: 1000, coinsPrice: 0,
                                         isTicketItemTax: true, tax: 12000, billsTax: 96, coinsTax: 43,
                                         isTicketItemDiscount: true, discountName: "Акция -10%", billsDiscount: 100, coinsDiscount: 0,
                                         dataMatrix: nil, barcode: "12345678")
        } catch {
            XCTFail("Ошибка при создании ticketItem1: \(error)")
        }
        
        var ticketItems: [TicketItem] = []
        
        if let item1 = ticketItem1 {
            ticketItems.append(item1)
        }
        
        if let item2 = ticketItem2 {
            ticketItems.append(item2)
        }
        
        if let item3 = ticketItem3 {
            ticketItems.append(item3)
        }
        
        do {
            if let ticket = ticket {
                ticketCpcr = try CommandTicketRequest.createCommandTicketRequestCpcr(ticket: ticket, ticketItems: ticketItems)
            } else {
                XCTFail("Ticket не был создан должным образом.")
            }
        } catch {
            XCTFail("Ошибка при создании CommandTicketRequest: \(error)")
        }
        
        do {
            if let ticketCpcr = ticketCpcr {
                let payload = ticketCpcr
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
                let deCommandTicketResponse = try CommandTicketResponse.createCommandTicketResponseCpcr(data: response)
                
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
