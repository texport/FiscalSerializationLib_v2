//
//  CommandTicketResponse.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 05.11.2024.
//

import Foundation

final class CommandTicketResponseBuilder {
    private let headerSize = 18
    private let ofdName: OFD
    private let kkmUserToServer: KKM
    private let commandTicketResponseData: Data
    
    private var kkmServerToUser: KKM?
    
    private var commandTicketResponseCpcr: Kkm_Proto_Response?
    
    private var command: CommandResponse?
    private var result: ResultResponse?
    private var fiscalSign: String?
    private var urlTicketOfd: String?
    private let commandTicketRequest: CommandTicketRequest
    
    private init(ofdName: OFD, kkmUserToServer: KKM, data: Data, commandTicketRequest: CommandTicketRequest) throws {
        self.ofdName = ofdName
        self.kkmUserToServer = kkmUserToServer
        self.commandTicketResponseData = data
        self.commandTicketRequest = commandTicketRequest
        try setupTicketResponse()
    }
    
    static func createTicketResponse(
            ofdName: OFD,
            kkmUserToServer: KKM,
            commandTicketResponseData: Data,
            commandTicketRequest: CommandTicketRequest
    ) throws -> CommandTicketResponse {
        // Создаём экземпляр
        let builder = try CommandTicketResponseBuilder(
            ofdName: ofdName,
            kkmUserToServer: kkmUserToServer,
            data: commandTicketResponseData,
            commandTicketRequest: commandTicketRequest
        )
        // Вызываем метод на экземпляре
        return try builder.buildTicketResponse()
    }
        
        // MARK: - Private Methods
    private func setupTicketResponse() throws {
        try setupKkmServerToUser()
        try setupKkmProtoResponse()
        try setupCommand()
        try setupResult()
        try setupTicketNumberOfd()
        try setupUrlTicketOfd()
    }
        
    private func buildTicketResponse() throws -> CommandTicketResponse {
        guard
            let kkmServerToUser = kkmServerToUser,
            let command = command,
            let result = result
        else {
            throw NSError(domain: "createTicketResponse", code: 1, userInfo: [
                NSLocalizedDescriptionKey: "Не удалось создать TicketResponse. Некоторые обязательные поля не инициализированы."
            ])
        }
        
        return CommandTicketResponse.create(
            with: (ofdName, kkmUserToServer, kkmServerToUser, command, result, fiscalSign, urlTicketOfd, commandTicketRequest)
        )
    }
    
    private func setupKkmProtoResponse() throws {
        commandTicketResponseCpcr = try deserializeCommandInfoResponse(data: commandTicketResponseData)
    }
    
    // Десериализация ответа на команду COMMAND_TICKET
    private func deserializeCommandInfoResponse(data: Data) throws -> Kkm_Proto_Response {
        // Проверяем, что данных достаточно для включения заголовка
        guard data.count > headerSize else {
            throw CommandsErrorEnum.commandLengthMessageError
        }
        
        // Отсекаем заголовок
        let payloadData = data.subdata(in: headerSize..<data.count)
        
        return try Kkm_Proto_Response(serializedBytes: payloadData)
    }
    
    private func setupKkmServerToUser() throws {
        let kgdId = commandTicketResponseCpcr?.service.regInfo.kkm.fnsKkmID
        let serialNumber = commandTicketResponseCpcr?.service.regInfo.kkm.serialNumber
        kkmServerToUser = try MessageHeader.fromData(commandTicketResponseData).toKKMForKGD(kgdId: kgdId ?? "111", kkmSerialNumber: serialNumber ?? "111")
    }
    
    // MARK: Command
    private func setupCommand() throws {
        command = try createCommandTicket(command: commandTicketResponseCpcr?.command)
    }
    
    private func createCommandTicket(command: Kkm_Proto_CommandTypeEnum?) throws -> CommandResponse {
        guard let command = command else {
            throw NSError(domain: "createCommandTicket", code: 1, userInfo: [
                NSLocalizedDescriptionKey: "От ОФД получен пустой код команды. ОФД нарушил протокол. Обратитесь в службу поддержки ОФД. Предоставьте ОФД идентификатор кассы , время попытки отправки транзакции, сообщите что код команды от ОФД пустой."])
        }
        
        return try Command.createCommandResponse(commandCpcr: command)
    }
    
    // MARK: Result
    private func setupResult() throws {
        result = try createTicketResult(result: commandTicketResponseCpcr?.result)
    }

    private func createTicketResult(result: Kkm_Proto_Result?) throws -> ResultResponse {
        guard let result = result else {
            throw NSError(domain: "createTicketResult", code: 1, userInfo: [
                NSLocalizedDescriptionKey: "От ОФД получен пустой код ответа. ОФД нарушил протокол. Обратитесь в службу поддержки ОФД. Предоставьте ОФД идентификатор кассы , время попытки отправки транзакции, сообщите что код ответа от ОФД пустой."])
        }
        
        return try Result.createResultResponse(resultCpcr: result)
    }

    // MARK: TicketNumber
    private func setupTicketNumberOfd() throws {
        if command?.command == 1, result?.resultCode == 0 {
            guard let ticketNumber = commandTicketResponseCpcr?.ticket.ticketNumber else {
                throw NSError(domain: "CommandTicketResponse", code: 1, userInfo: [
                    NSLocalizedDescriptionKey: "ОФД отправил код команды 0, но нарушил протокол и не отправил фискальный признак. Обратитесь в службу поддержки ОФД. Предоставьте ОФД идентификатор кассы, время попытки отправки чека, сообщите что ОФД не передал фискальный признак, но чек принял."])
            }
            
            fiscalSign = try createTicketNumberOfd(ticketNumber: ticketNumber)
        }
    }
    
    private func createTicketNumberOfd(ticketNumber: String) throws -> String {
        return try TicketNumber.createTicketNumber(ticketNumber: ticketNumber)
    }
    
    // MARK: UrlTicketOfd
    private func setupUrlTicketOfd() throws {
        if command?.command == 1, result?.resultCode == 0 {
            guard let urlTicketOfd = commandTicketResponseCpcr?.ticket.qrCode else {
                throw NSError(domain: "CommandTicketResponse", code: 1, userInfo: [
                    NSLocalizedDescriptionKey: "ОФД отправил код команды 0, но нарушил протокол и не отправил ссылку на чек. Обратитесь в службу поддержки ОФД. Предоставьте ОФД идентификатор кассы, время попытки отправки чека, сообщите что ОФД не передал ссылку на чек."])
            }
            
            self.urlTicketOfd = try createUrlTicketOfd(urlTicketOfd: urlTicketOfd)
        }
    }
    
    private func createUrlTicketOfd(urlTicketOfd: Data) throws -> String {
        return try UrlTicketOfd.createUrlTicketOfd(urlTicketOfd: urlTicketOfd)
    }
}
