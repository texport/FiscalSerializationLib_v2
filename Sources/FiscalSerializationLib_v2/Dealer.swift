//
//  Dealer.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 11.12.2024.
//

import Foundation

public struct Dealer {
    static func makeDelivery(command: CommandProtocol, ofd: OFD, kkm: KKM) throws -> ResponseProtocol {
        switch command.commandCode {
        case .commandInfo:
            let commandInfoRequestCpcr = try CommandInfo.createCommandInfoRequestCpcr(commandInfo: command as! CommandInfoRequest, kkmUserToServer: kkm)
            let commandInfoResponseCpcr = try OfdConnector.shared.sendToServer(message: commandInfoRequestCpcr, serverIP: ofd.ip, serverPort: ofd.port)
            
            return try CommandInfo.createCommandInfoResponse(ofd: ofd, kkmUserToServer: kkm, commandInfoResponseData: commandInfoResponseCpcr)
        case .commandTicket:
            let commandTicketRequestCpcr = try CommandTicket.createCommandTicketRequestCpcr(commandTicket: command as! CommandTicketRequest, kkmUserToServer: kkm)
            let commandTicketResponseCpcr = try OfdConnector.shared.sendToServer(message: commandTicketRequestCpcr, serverIP: ofd.ip, serverPort: ofd.port)
            
            return try CommandTicket.createCommandTicketResponse(ofd: ofd, kkmUserToServer: kkm, commandTicketResponseData: commandTicketResponseCpcr, commandTickerRequest: command as! CommandTicketRequest)
        default:
            throw NSError(domain: "Dealer", code: -1, userInfo: [
                            NSLocalizedDescriptionKey: "Неизвестный тип команды"
            ])
        }
    }
}
