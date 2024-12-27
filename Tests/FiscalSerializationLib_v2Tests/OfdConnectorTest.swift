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
    let kkm = KKM(idKkm: 201129, tokenKkm: 63568596, reqNum: 11, kgdId: "620500001720", kkmSerialNumber: "KTCD1123342507572")
    // 2. Создаем сущность ОФД куда будем отправлять
    let ofd = OfdEnum.kazakhtelecom.getPlatformInfo(for: .test)
    
    func testSendCommandInfoToOfd() {
        // Создаём команду
        let command = CommandInfoRequest()
        do {
            // Отправляем команду и получаем ответ
            let dealer = try Dealer.makeDelivery(command: command, ofd: ofd, kkm: kkm)
            let commandInfoResponse = dealer as! CommandInfoResponse
            
            // Отладочный вывод структуры в читаемом виде
            print("--------------------------------------")
            print("Это результат в формате читаемого вывода:")
            print("--------------------------------------")
            printReadable(commandInfoResponse)
            
            // Проверка, что значение command совпадает с ожидаемым
            XCTAssert(commandInfoResponse.command.command == 5, "Поле 'command' не содержит ожидаемое значение")
        } catch {
            XCTFail("Ошибка при отправке данных в ОФД: \(error)")
        }
    }
    
    func testSendCommandTicketRequest() {
        var commandTicket: CommandTicketRequest?
        var ticketItems: [TicketItem] = []
        
        do {
            let ticketItem1 = try TicketItem(nameTicketItem: "Игрушка SuperMan", sectionCode: "1", quantity: 1000, measureUnitCode: .piece,
                                         billsPrice: 1000, coinsPrice: 0,
                                         isTicketItemTax: true, tax: 12000, billsTax: 96, coinsTax: 43,
                                         isTicketItemDiscount: true, discountName: "Акция -10%", billsDiscount: 100, coinsDiscount: 0,
                                         dataMatrix: nil, barcode: "12345678")
            let ticketItem2 = try TicketItem(nameTicketItem: "Игрушка SuperMan", sectionCode: "1", quantity: 1000, measureUnitCode: .piece,
                                         billsPrice: 1000, coinsPrice: 0,
                                         isTicketItemTax: true, tax: 12000, billsTax: 96, coinsTax: 43,
                                         isTicketItemDiscount: true, discountName: "Акция -10%", billsDiscount: 100, coinsDiscount: 0,
                                         dataMatrix: nil, barcode: "12345678")
            let ticketItem3 = try TicketItem(nameTicketItem: "Игрушка SuperMan", sectionCode: "1", quantity: 1000, measureUnitCode: .piece,
                                         billsPrice: 1000, coinsPrice: 0,
                                         isTicketItemTax: true, tax: 12000, billsTax: 96, coinsTax: 43,
                                         isTicketItemDiscount: true, discountName: "Акция -10%", billsDiscount: 100, coinsDiscount: 0,
                                         dataMatrix: nil, barcode: "12345678")
            ticketItems.append(contentsOf: [ticketItem1, ticketItem2, ticketItem3])
        } catch {
            XCTFail("Ошибка при создании ticketItem1: \(error)")
        }
        
        do {
            
            commandTicket = try CommandTicketRequest(isTicketOnline: true, offlineTicketNumber: nil,
                                              offlinePeriodBeginYear: nil, offlinePeriodBeginMonth: nil, offlinePeriodBeginDay: nil, offlinePeriodBeginHour: nil, offlinePeriodBeginMinute: nil, offlinePeriodBeginSecond: nil,
                                              offlinePeriodEndYear: nil, offlinePeriodEndMonth: nil, offlinePeriodEndDay: nil, offlinePeriodEndHour: nil, offlinePeriodEndMinute: nil, offlinePeriodEndSecond: nil,
                                              kgdId: "620500001720", kkmOfdId: "201129", kkmSerialNumber: "KTCD1123342507572", title: "ИП МИЧКА ПАВЕЛ АНДРЕЕВИЧ", address: "г. Астана, ул. Ленина 33", iinOrBinOrg: "960624350642", oked: "7281",
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
                                              isCustomer: true, iinOrBin: "123456789123", phone: "+77777777777", email: "mail@mail.kz",
                                              ticketItems: ticketItems)
        } catch {
            XCTFail("Ошибка при создании Ticket: \(error)")
        }
        
        do {
            guard let commandTicketRequest = commandTicket else {
                XCTFail("Не удалось извлечь commandticket")
                return
            }
            // Отправляем команду и получаем ответ
            let dealer = try Dealer.makeDelivery(command: commandTicketRequest, ofd: ofd, kkm: kkm)
            guard let commandTicketResponse = dealer as? CommandTicketResponse else {
                XCTFail("Не удалось привести dealer к типу CommandTicketResponse")
                return
            }
            
            // Отладочный вывод структуры в читаемом виде
            print("--------------------------------------")
            print("Это результат в формате читаемого вывода:")
            print("--------------------------------------")
            printReadable(commandTicketResponse)
            
            // Проверка, что значение command совпадает с ожидаемым
            XCTAssert(commandTicketResponse.command.command == 1, "Поле 'command' не содержит ожидаемое значение")
        } catch {
            XCTFail("Ошибка при отправке данных в ОФД: \(error)")
        }
    }

    func printReadable<T>(_ object: T, name: String = "Объект", indent: Int = 0) {
        let mirror = Mirror(reflecting: object)
        let indentation = String(repeating: " ", count: indent)
        
        if indent == 0 {
            print("==============================================================")
            print("\(name): \(mirror.subjectType)")
            print("==============================================================")
        } else {
            print("\(indentation)\(name): \(mirror.subjectType) {")
        }
        
        for child in mirror.children {
            if let label = child.label {
                let valueMirror = Mirror(reflecting: child.value)
                if valueMirror.children.isEmpty {
                    print("\(indentation)  \(label): \(child.value)")
                } else {
                    printReadable(child.value, name: label, indent: indent + 2)
                }
            } else {
                print("\(indentation)  \(child.value)")
            }
        }
        
        if indent > 0 {
            print("\(indentation)}")
        }
    }
}
