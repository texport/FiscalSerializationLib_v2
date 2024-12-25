//
//  OfdConnectorTest.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 24.09.2024.
//

import XCTest
@testable import FiscalSerializationLib_v2

class OfdConnectorTests: XCTestCase {
    // 1. Создаем сущность кассы для которой будем потправлять команду
    let kkm = KKM(idKkm: 201129, tokenKkm: 28430364, reqNum: 9, kgdId: "123", kkmSerialNumber: "123")
    // 2. Создаем сущность ОФД куда будем отправлять
    let ofd = OfdEnum.kazakhtelecom.getPlatformInfo(for: .test)
    
    func testSendCommandInfoToOfd() {
        // 3. Создаем командку которую собираемся отправлять
        let command = CommandInfoRequest()
        do {
            // 4. Отправляем на сервер и получаем ответ
            let dealer = try Dealer.makeDelivery(command: command, ofd: ofd, kkm: kkm)
            let commandInfoResponse = dealer as! CommandInfoResponse
            
            dump(commandInfoResponse)
            print("--------------------------------------\nЭто отчет в виде библиотеки:\n--------------------------------------")
            dump(commandInfoResponse.report)
            print("--------------------------------------")
            
            // Проверяем мою сервисную часть для CommandInfo
            print("--------------------------------------\nЭто сервисная часть в виде библиотеки:\n--------------------------------------")
            dump(commandInfoResponse.service)
            print("--------------------------------------")
            
            // Проверяем, что свойства не пустые
            XCTAssert(commandInfoResponse.command.command == 5, "Поле 'command' не содержит ожидаемое значение")
        } catch {
            XCTFail("Ошибка при отправке данных в ОФД: \(error)")
        }
    }
    
//    func testSendCommandTicketRequest() {
//        var ticket: Ticket?
//        var ticketItem1: TicketItem?
//        var ticketItem2: TicketItem?
//        var ticketItem3: TicketItem?
//        var ticketCpcr: Data?
//        
//        do {
//            ticket = try Ticket(isTicketOnline: true, offlineTicketNumber: nil,
//                                offlinePeriodBeginYear: nil, offlinePeriodBeginMonth: nil, offlinePeriodBeginDay: nil, offlinePeriodBeginHour: nil, offlinePeriodBeginMinute: nil, offlinePeriodBeginSecond: nil,
//                                offlinePeriodEndYear: nil, offlinePeriodEndMonth: nil, offlinePeriodEndDay: nil, offlinePeriodEndHour: nil, offlinePeriodEndMinute: nil, offlinePeriodEndSecond: nil,
//                                kgdId: "381928371231", kkmOfdId: "200956", kkmSerialNumber: "141412323", title: "ИП МИЧКА ПАВЕЛ АНДРЕЕВИЧ", address: "г. Астана, ул. Ленина 33", iinOrBinOrg: "960624350642", oked: "7281",
//                                frShiftNumber: 1,
//                                operation: 2,
//                                year: 2024, month: 10, day: 31, hour: 23, minute: 0, second: 0,
//                                codeOperator: 1, nameOperator: "Сергей Иванов",
//                                isCash: true, billsCashSum: 2700, coinsCashSum: 0, billsCashTaken: 2700, coinsCashTaken: 0,
//                                isCard: false, billsCardSum: nil, coinsCardSum: nil,
//                                isMobile: false, billsMobileSum: nil, coinsMobileSum: nil,
//                                isTicketAllTax: false, tax: nil, billsTax: nil, coinsTax: nil,
//                                isTicketAllDiscount: false, discountName: nil, billsDiscount: nil, coinsDiscount: nil,
//                                billsTotal: 2700, coinsTotal: 0,
//                                isCustomer: true, iinOrBin: "123456789123", phone: "+77777777777", email: "mail@mail.kz")
//        } catch {
//            XCTFail("Ошибка при создании Ticket: \(error)")
//        }
//        
//        do {
//            ticketItem1 = try TicketItem(nameTicketItem: "Игрушка SuperMan", sectionCode: "1", quantity: 1000, measureUnitCode: .piece,
//                                         billsPrice: 1000, coinsPrice: 0,
//                                         isTicketItemTax: true, tax: 12000, billsTax: 96, coinsTax: 43,
//                                         isTicketItemDiscount: true, discountName: "Акция -10%", billsDiscount: 100, coinsDiscount: 0,
//                                         dataMatrix: nil, barcode: "12345678")
//            ticketItem2 = try TicketItem(nameTicketItem: "Игрушка SuperMan", sectionCode: "1", quantity: 1000, measureUnitCode: .piece,
//                                         billsPrice: 1000, coinsPrice: 0,
//                                         isTicketItemTax: true, tax: 12000, billsTax: 96, coinsTax: 43,
//                                         isTicketItemDiscount: true, discountName: "Акция -10%", billsDiscount: 100, coinsDiscount: 0,
//                                         dataMatrix: nil, barcode: "12345678")
//            ticketItem3 = try TicketItem(nameTicketItem: "Игрушка SuperMan", sectionCode: "1", quantity: 1000, measureUnitCode: .piece,
//                                         billsPrice: 1000, coinsPrice: 0,
//                                         isTicketItemTax: true, tax: 12000, billsTax: 96, coinsTax: 43,
//                                         isTicketItemDiscount: true, discountName: "Акция -10%", billsDiscount: 100, coinsDiscount: 0,
//                                         dataMatrix: nil, barcode: "12345678")
//        } catch {
//            XCTFail("Ошибка при создании ticketItem1: \(error)")
//        }
//        
//        var ticketItems: [TicketItem] = []
//        
//        if let item1 = ticketItem1 {
//            ticketItems.append(item1)
//        }
//        
//        if let item2 = ticketItem2 {
//            ticketItems.append(item2)
//        }
//        
//        if let item3 = ticketItem3 {
//            ticketItems.append(item3)
//        }
//        
//        do {
//            if let ticket = ticket {
//                ticketCpcr = try CommandTicketRequest.createCommandTicketRequestCpcr(ticket: ticket, ticketItems: ticketItems)
//            } else {
//                XCTFail("Ticket не был создан должным образом.")
//            }
//        } catch {
//            XCTFail("Ошибка при создании CommandTicketRequest: \(error)")
//        }
//        
//        do {
//            if let ticketCpcr = ticketCpcr {
//                let payload = ticketCpcr
//                let header = MessageHeader.toData(id: id, token: token, reqNum: reqNum, payload: payload)
//                
//                // Формируем полное сообщение (header + payload)
//                var message = Data()
//                message.append(header)
//                message.append(payload)
//
//                print("Полное сообщение (hex): \(message.map { String(format: "%02hhx", $0) }.joined())")
//
//                // Отправляем сообщение на сервер
//                let response = try OfdConnector.shared.sendToServer(message: message, serverIP: serverOfd.ip, serverPort: serverOfd.port)
//                print("Сообщение от сервера:\n \(response), длинна сообщения: \(response.count)")
//                
//                // Проверяем ответ от сервера
//                let messageResponse = try MessageHeader.fromData(response)
//                let deCommandTicketResponse = try CommandTicketResponse.getTicketResponse(ofdName: .kazakhtelecom, data: response)
//                
//                print("Заголовок от сервера:\n \(messageResponse)")
//                print("Payload от сервера:\n \(deCommandTicketResponse)")
//                // В зависимости от специфики протокола можно добавить больше проверок
//                XCTAssert(!response.isEmpty, "Ответ от сервера пустой")
//            } else {
//                XCTFail("TicketCpcr не удалось извлечь.")
//            }
//        } catch {
//            XCTFail("Ошибка при отправке данных в ОФД: \(error)")
//        }
//    }
}
