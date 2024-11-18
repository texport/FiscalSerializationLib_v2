//
//  CommandTicketResponse.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 05.11.2024.
//

import Foundation

final class CommandTicketResponse {
    private let ofdName: OfdEnum
    private let commandTicketResponseCpcr: Data
    private var ticketHeader: MessageHeader?
    private var ticketResponseCpcr: Kkm_Proto_Response?
    
    // Какую команду вернул ОФД
    private var command: UInt32?
    private var commandText: String?
    
    // Результаты отправки чека
    private var resultCode: UInt32?
    private var resultText: String?
    
    // Фискальный признак
    private var ticketNumberOfd: String?
    
    // Ссылка на чек в ОФД
    private var urlTicketOfd: String?
    
    private init(ofdName: OfdEnum, data: Data) throws {
        self.ofdName = ofdName
        self.commandTicketResponseCpcr = data
        try setupTicketResponse()
    }
    
    static func getTicketResponse(ofdName: OfdEnum, data: Data) throws -> TicketResponse {
        let commandTicketResponse = try CommandTicketResponse(ofdName: ofdName, data: data)
        return try commandTicketResponse.createTicketResponse()
    }
    
    // MARK: SETUP
    private func setupTicketResponse() throws {
        try setupKkmProtoResponse()
        try setupCommand()
        try setupResult()
        try setupTicketNumberOfd()
        try setupUrlTicketOfd()
    }
    
    // MARK: Десериализация
    private func setupKkmProtoResponse() throws {
        ticketHeader = try deserializeCommandTicketResponse(data: commandTicketResponseCpcr).0
        ticketResponseCpcr = try deserializeCommandTicketResponse(data: commandTicketResponseCpcr).1
    }
    
    private func deserializeCommandTicketResponse(data: Data) throws -> (MessageHeader, Kkm_Proto_Response) {
        let headerSize = 18
        // Проверяем, что данных достаточно для включения заголовка
        guard data.count > headerSize else {
            throw NSError(domain: "deserializeCommandTicketResponse", code: 1, userInfo: [NSLocalizedDescriptionKey: "Данных недостаточно"])
        }
        print(data.count)
        
        // Отсекаем заголовок
        let payloadData = data.subdata(in: headerSize..<data.count)
        
        // Десериализация header
        let header = try MessageHeader.fromData(data)
        // Десериализация payload
        let response = try Kkm_Proto_Response(serializedBytes: payloadData)
        print("deserializeCommandTicketResponse - \(response)")
        // Возвращаем десериализованный ответ
        return (header, response)
    }
    
    // MARK: Command
    private func setupCommand() throws {
        let (command, commandText) = try createCommandTicket(command: ticketResponseCpcr?.command)
        self.command = command
        self.commandText = commandText
    }
    
    private func createCommandTicket(command: Kkm_Proto_CommandTypeEnum?) throws -> (UInt32, String) {
        guard let command = command else {
            throw NSError(domain: "createCommandTicket", code: 1, userInfo: [
                NSLocalizedDescriptionKey: "От ОФД получен пустой код команды. ОФД нарушил протокол. Обратитесь в службу поддержки ОФД. Предоставьте ОФД идентификатор кассы , время попытки отправки транзакции, сообщите что код команды от ОФД пустой."])
        }
        
        return try Command.createCommand(command: command)
    }
    
    // MARK: Result
    private func setupResult() throws {
        let (resultCode, resultText) = try createTicketResult(result: ticketResponseCpcr?.result)
        self.resultCode = resultCode
        self.resultText = resultText
    }

    private func createTicketResult(result: Kkm_Proto_Result?) throws -> (UInt32, String) {
        guard let result = result else {
            throw NSError(domain: "createTicketResult", code: 1, userInfo: [
                NSLocalizedDescriptionKey: "От ОФД получен пустой код ответа. ОФД нарушил протокол. Обратитесь в службу поддержки ОФД. Предоставьте ОФД идентификатор кассы , время попытки отправки транзакции, сообщите что код ответа от ОФД пустой."])
        }
        
        return try Result.createResult(result: result)
    }

    // MARK: TicketNumber
    private func setupTicketNumberOfd() throws {
        if command == 1, resultCode == 0 {
            guard let ticketNumber = ticketResponseCpcr?.ticket.ticketNumber else {
                throw NSError(domain: "CommandTicketResponse", code: 1, userInfo: [
                    NSLocalizedDescriptionKey: "ОФД отправил код команды 0, но нарушил протокол и не отправил фискальный признак. Обратитесь в службу поддержки ОФД. Предоставьте ОФД идентификатор кассы, время попытки отправки чека, сообщите что ОФД не передал фискальный признак, но чек принял."])
            }
            
            ticketNumberOfd = try createTicketNumberOfd(ticketNumber: ticketNumber)
        }
    }
    
    private func createTicketNumberOfd(ticketNumber: String) throws -> String {
        return try TicketNumber.createTicketNumber(ticketNumber: ticketNumber)
    }
    
    // MARK: UrlTicketOfd
    private func setupUrlTicketOfd() throws {
        if command == 1, resultCode == 0 {
            guard let urlTicketOfd = ticketResponseCpcr?.ticket.qrCode else {
                throw NSError(domain: "CommandTicketResponse", code: 1, userInfo: [
                    NSLocalizedDescriptionKey: "ОФД отправил код команды 0, но нарушил протокол и не отправил ссылку на чек. Обратитесь в службу поддержки ОФД. Предоставьте ОФД идентификатор кассы, время попытки отправки чека, сообщите что ОФД не передал ссылку на чек."])
            }
            
            self.urlTicketOfd = try createUrlTicketOfd(urlTicketOfd: urlTicketOfd)
        }
    }
    
    private func createUrlTicketOfd(urlTicketOfd: Data) throws -> String {
        return try UrlTicketOfd.createUrlTicketOfd(urlTicketOfd: urlTicketOfd)
    }
    
    private func createTicketResponse() throws -> TicketResponse {
        guard
            let idKkmOfd = ticketHeader?.id,
            let tokenOfd = ticketHeader?.token,
            let reqNumOfd = ticketHeader?.reqNum,
            let command = command,
            let commandText = commandText,
            let resultCode = resultCode,
            let resultText = resultText
            else {
                throw NSError(domain: "createTicketResponse", code: 1, userInfo: [
                    NSLocalizedDescriptionKey: "Не удалось создать TicketResponse. Некоторые обязательные поля не инициализированы."
                ])
            }
        
        return TicketResponse(ofdName: ofdName, idKkmOfd: idKkmOfd, tokenOfd: tokenOfd, reqNumOfd: reqNumOfd, command: command, commandText: commandText, resultCode: resultCode, resultText: resultText, fiscalSign: ticketNumberOfd, urlTicketOfd: urlTicketOfd)
    }
}
